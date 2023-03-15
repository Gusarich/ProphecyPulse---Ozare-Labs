import { ContractSystem } from 'ton-emulator';
import { toNano, Address } from 'ton-core';
import { expect } from 'chai';
import { Treasure } from 'ton-emulator';
import { Bet } from '../wrappers/Bet';
import { Event } from '../wrappers/Event';

function parseIntAddress(address: bigint): Address {
    return Address.parseRaw('0:' + address.toString(16));
}

describe('ozare contracts', () => {
    var system: ContractSystem;
    var oracle: Treasure;
    var players: Treasure[] = [];
    var uid: number = 0;

    before(async () => {
        system = await ContractSystem.create();
        oracle = await system.treasure('oracle');
        for (let i = 0; i < 10; i += 1) {
            players.push(await system.treasure('player' + i));
        }
    });

    it('should accept bets', async () => {
        const event = await Event.create(system, oracle.address, uid++);

        await event.bet(players[0], false, toNano('1'));
        let txs = await system.run();
        expect(txs).to.have.lengthOf(4);
        expect(txs[2].endStatus).to.equal('active');
        if (txs[3].inMessage?.info.type == 'internal') {
            expect(txs[3].inMessage?.info.value.coins).to.equal(49000000n);
        }

        await event.bet(players[1], true, toNano('2'));
        txs = await system.run();
        expect(txs).to.have.lengthOf(4);
        expect(txs[2].endStatus).to.equal('active');
        if (txs[3].inMessage?.info.type == 'internal') {
            expect(txs[3].inMessage?.info.value.coins).to.equal(49000000n);
        }

        await event.bet(players[0], false, toNano('3'));
        txs = await system.run();
        expect(txs).to.have.lengthOf(4);
        expect(txs[2].endStatus).to.equal('active');
        if (txs[3].inMessage?.info.type == 'internal') {
            expect(txs[3].inMessage?.info.value.coins).to.equal(49000000n);
        }

        const [amountA, amountB] = await event.getTotalBets();
        expect(amountA).to.be.equal(toNano('4'));
        expect(amountB).to.be.equal(toNano('2'));
    });

    it('should start event', async () => {
        const event = await Event.create(system, oracle.address, uid++);
        await event.startEvent(oracle);
        let txs = await system.run();
        expect(txs).to.have.lengthOf(3);
        if (txs[1].description.type == 'generic') {
            expect(txs[1].description.aborted).to.be.false;
        }
        expect(await event.getStartedFinished()).to.eql([true, false]);
    });

    it('should payout house edge to oracle (5%)', async () => {
        const event = await Event.create(system, oracle.address, uid++);
        await event.bet(players[0], false, toNano('50'));
        await system.run();
        await event.startEvent(oracle);
        let txs = await system.run();

        expect(txs).to.have.lengthOf(4);
        if (txs[2].inMessage?.info.type == 'internal') {
            expect(txs[2].inMessage.info.dest.toRawString()).to.equal(
                oracle.address.toRawString()
            );
            expect(txs[2].inMessage.info.value.coins).to.equal(toNano('2.5'));
        }
    });

    it('should payout house edge to oracle (10%)', async () => {
        const event = await Event.create(system, oracle.address, uid++);
        await event.bet(players[0], false, toNano('100'));
        await system.run();
        await event.startEvent(oracle);
        let txs = await system.run();

        expect(txs).to.have.lengthOf(4);
        if (txs[2].inMessage?.info.type == 'internal') {
            expect(txs[2].inMessage.info.dest.toRawString()).to.equal(
                oracle.address.toRawString()
            );
            expect(txs[2].inMessage.info.value.coins).to.equal(toNano('10'));
        }
    });

    it('should finish event', async () => {
        const event = await Event.create(system, oracle.address, uid++);
        await event.startEvent(oracle);
        await system.run();
        await event.finishEvent(oracle, true);
        let txs = await system.run();
        expect(txs).to.have.lengthOf(3);
        if (txs[1].description.type == 'generic') {
            expect(txs[1].description.aborted).to.be.false;
        }
        expect(await event.getStartedFinished()).to.eql([true, true]);
    });

    it('should payout winnings', async () => {
        const event = await Event.create(system, oracle.address, uid++);
        await event.bet(players[0], false, toNano('1'));
        await event.bet(players[1], true, toNano('2'));
        await event.bet(players[2], true, toNano('1'));
        await event.bet(players[1], false, toNano('1'));

        let txs = await system.run();
        expect(txs).to.have.lengthOf(16);
        const deployTxs = txs.filter(
            (tx) =>
                tx.oldStatus == 'uninitialized' &&
                tx.endStatus == 'active' &&
                tx.outMessagesCount == 0
        );
        const betAddresses = deployTxs.map((tx) => parseIntAddress(tx.address));
        const bets = betAddresses.map(
            (addr) => new Bet(addr, system.contract(addr))
        );
        expect(bets).to.have.lengthOf(4);

        const [amountA, amountB] = await event.getTotalBets();
        expect(amountA).to.be.equal(toNano('2'));
        expect(amountB).to.be.equal(toNano('3'));

        await event.startEvent(oracle);
        await event.finishEvent(oracle, false);
        await system.run();

        await bets[0].close(players[0]);
        txs = await system.run();
        expect(txs).to.have.lengthOf(4);
        if (txs[3].inMessage?.info.type == 'internal') {
            expect(Number(txs[3].inMessage?.info.value.coins)).to.be.gte(2.5e9);
        }

        await bets[1].close(players[1]);
        txs = await system.run();
        expect(txs).to.have.lengthOf(4);

        await bets[2].close(players[2]);
        txs = await system.run();
        expect(txs).to.have.lengthOf(4);

        await bets[3].close(players[1]);
        txs = await system.run();
        expect(txs).to.have.lengthOf(4);
        if (txs[3].inMessage?.info.type == 'internal') {
            expect(Number(txs[3].inMessage?.info.value.coins)).to.be.gte(2.5e9);
        }

        expect(bets.map((b) => b.executor!.balance)).to.eql([0n, 0n, 0n, 0n]);
        expect(Number(event.executor!.balance)).to.be.approximately(
            0.36e9,
            0.1e9
        );
    });

    it('should not accept bets after the start', async () => {
        const event = await Event.create(system, oracle.address, uid++);

        await event.bet(players[0], false, toNano('1'));
        let txs = await system.run();
        expect(txs).to.have.lengthOf(4);
        expect(txs[2].endStatus).to.equal('active');
        if (txs[3].inMessage?.info.type == 'internal') {
            expect(txs[3].inMessage?.info.value.coins).to.equal(49000000n);
        }

        await event.startEvent(oracle);
        await system.run();

        await event.bet(players[0], false, toNano('1'));
        txs = await system.run();
        expect(txs).to.have.lengthOf(3);

        const [amountA, amountB] = await event.getTotalBets();
        expect(amountA).to.be.equal(toNano('1'));
        expect(amountB).to.be.equal(toNano('0'));
    });

    it('should not payout winnings before the end', async () => {
        const event = await Event.create(system, oracle.address, uid++);

        await event.bet(players[0], false, toNano('1'));
        await event.bet(players[1], true, toNano('2'));
        await event.bet(players[2], true, toNano('1'));
        await event.bet(players[1], false, toNano('1'));

        let txs = await system.run();
        expect(txs).to.have.lengthOf(16);
        const deployTxs = txs.filter(
            (tx) =>
                tx.oldStatus == 'uninitialized' &&
                tx.endStatus == 'active' &&
                tx.outMessagesCount == 0
        );
        const betAddresses = deployTxs.map((tx) => parseIntAddress(tx.address));
        const bets = betAddresses.map(
            (addr) => new Bet(addr, system.contract(addr))
        );
        expect(bets).to.have.lengthOf(4);

        await bets[0].close(players[0]);
        txs = await system.run();
        if (txs[3].inMessage?.info.type == 'internal') {
            expect(txs[3].inMessage.info.bounced).to.be.true;
        }

        await event.startEvent(oracle);
        await system.run();

        await bets[0].close(players[0]);
        txs = await system.run();
        if (txs[3].inMessage?.info.type == 'internal') {
            expect(txs[3].inMessage.info.bounced).to.be.true;
        }

        await event.finishEvent(oracle, true);
        await system.run();

        await bets[0].close(players[0]);
        txs = await system.run();
        if (txs[3].inMessage?.info.type == 'internal') {
            expect(txs[3].inMessage.info.bounced).to.be.false;
            expect(txs[3].inMessage.info.dest.toRawString()).to.equal(
                players[0].address.toRawString()
            );
        }

        await bets[1].close(players[1]);
        txs = await system.run();
        if (txs[3].inMessage?.info.type == 'internal') {
            expect(txs[3].inMessage.info.bounced).to.be.false;
            expect(txs[3].inMessage.info.dest.toRawString()).to.equal(
                players[1].address.toRawString()
            );
            expect(
                Number(txs[3].inMessage.info.value.coins)
            ).to.be.approximately(3.5e9, 0.1e9);
        }
    });

    it('should not start event if caller is not oracle', async () => {
        const event = await Event.create(system, oracle.address, uid++);
        await event.startEvent(players[0]);
        let txs = await system.run();
        if (txs[2].inMessage?.info.type == 'internal') {
            expect(txs[2].inMessage.info.bounced).to.be.true;
        }
        expect((await event.getStartedFinished())[0]).to.be.false;
    });

    it('should not finish event if caller is not oracle', async () => {
        const event = await Event.create(system, oracle.address, uid++);
        await event.startEvent(oracle);
        await system.run();
        await event.finishEvent(players[0], false);
        let txs = await system.run();
        if (txs[2].inMessage?.info.type == 'internal') {
            expect(txs[2].inMessage.info.bounced).to.be.true;
        }
        expect(await event.getStartedFinished()).to.eql([true, false]);
    });

    it('should not close the bet if caller is not owner', async () => {
        const event = await Event.create(system, oracle.address, uid++);

        await event.bet(players[0], false, toNano('1'));
        await event.bet(players[1], true, toNano('1'));

        let txs = await system.run();
        const deployTxs = txs.filter(
            (tx) =>
                tx.oldStatus == 'uninitialized' &&
                tx.endStatus == 'active' &&
                tx.outMessagesCount == 0
        );
        const betAddresses = deployTxs.map((tx) => parseIntAddress(tx.address));
        const bets = betAddresses.map(
            (addr) => new Bet(addr, system.contract(addr))
        );

        await bets[0].close(players[1]);
        txs = await system.run();
        if (txs[1].description.type == 'generic') {
            expect(txs[1].description.aborted).to.be.true;
        }
    });
});
