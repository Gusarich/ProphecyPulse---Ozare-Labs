"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Event = void 0;
const func_js_1 = require("@ton-community/func-js");
const fs_1 = require("fs");
const ton_core_1 = require("ton-core");
const StateInit_1 = require("ton-core/dist/types/StateInit");
const Bet_1 = require("./Bet");
class Event {
    address;
    init;
    executor;
    client;
    constructor(address, init, executor) {
        this.address = address;
        this.init = init;
        if ('get' in executor) {
            this.executor = executor;
        }
        else {
            this.client = executor;
        }
    }
    async getBetAddress(better, outcome) {
        let stateInit = (0, ton_core_1.beginCell)()
            .storeUint(6, 5)
            .storeRef(await Bet_1.Bet.getCode())
            .storeRef((0, ton_core_1.beginCell)()
            .storeAddress(better)
            .storeAddress(this.address)
            .storeBit(outcome)
            .storeUint(0, 256)
            .endCell())
            .endCell();
        return new ton_core_1.Address(0, stateInit.hash());
    }
    static async create(system, oracle, uid) {
        const stateInit = await this.getStateInit(oracle, uid);
        const address = (0, ton_core_1.contractAddress)(0, stateInit);
        if ('contract' in system) {
            return new Event(address, stateInit, system.contract(address));
        }
        return new Event(address, stateInit, system);
    }
    async deploy(via) {
        if ('sendTransaction' in via) {
            await via.sendTransaction({
                validUntil: Math.floor(Date.now() / 1000) + 600,
                messages: [
                    {
                        address: this.address.toRawString(),
                        amount: (0, ton_core_1.toNano)('0.25').toString(),
                        stateInit: (0, ton_core_1.beginCell)()
                            .store((0, StateInit_1.storeStateInit)(this.init))
                            .endCell()
                            .toBoc()
                            .toString('base64'),
                    },
                ],
            });
        }
        else {
            await via.send({
                to: this.address,
                init: this.init,
                value: (0, ton_core_1.toNano)('0.25'),
            });
        }
    }
    async bet(via, outcome, amount) {
        let betAddress;
        if ('sendTransaction' in via) {
            await via.sendTransaction({
                validUntil: Math.floor(Date.now() / 1000) + 600,
                messages: [
                    {
                        address: this.address.toRawString(),
                        amount: ((0, ton_core_1.toNano)('0.25') + amount).toString(),
                        stateInit: (0, ton_core_1.beginCell)()
                            .store((0, StateInit_1.storeStateInit)(this.init))
                            .endCell()
                            .toBoc()
                            .toString('base64'),
                        payload: (0, ton_core_1.beginCell)()
                            .storeUint(0x60e6b243, 32)
                            .storeBit(outcome)
                            .storeUint(amount, 256)
                            .endCell()
                            .toBoc()
                            .toString('base64'),
                    },
                ],
            });
            betAddress = await this.getBetAddress(ton_core_1.Address.parse(via.wallet.account.address), outcome);
        }
        else {
            await via.send({
                to: this.address,
                init: this.init,
                value: (0, ton_core_1.toNano)('0.25') + (0, ton_core_1.toNano)(amount.toString()),
                body: (0, ton_core_1.beginCell)()
                    .storeUint(0x60e6b243, 32)
                    .storeBit(outcome)
                    .storeUint((0, ton_core_1.toNano)(amount.toString()), 256)
                    .endCell(),
            });
            betAddress = await this.getBetAddress(via.address, outcome);
        }
        return new Bet_1.Bet(betAddress, (this.executor || this.client));
    }
    async startEvent(via) {
        if ('sendTransaction' in via) {
            await via.sendTransaction({
                validUntil: Math.floor(Date.now() / 1000) + 600,
                messages: [
                    {
                        address: this.address.toRawString(),
                        amount: (0, ton_core_1.toNano)('0.05').toString(),
                        stateInit: (0, ton_core_1.beginCell)()
                            .store((0, StateInit_1.storeStateInit)(this.init))
                            .endCell()
                            .toBoc()
                            .toString('base64'),
                        payload: (0, ton_core_1.beginCell)()
                            .storeUint(0x380ce405, 32)
                            .endCell()
                            .toBoc()
                            .toString('base64'),
                    },
                ],
            });
        }
        else {
            await via.send({
                to: this.address,
                init: this.init,
                value: (0, ton_core_1.toNano)('0.05'),
                body: (0, ton_core_1.beginCell)().storeUint(0x380ce405, 32).endCell(),
            });
        }
    }
    async finishEvent(via, winner) {
        if ('sendTransaction' in via) {
            await via.sendTransaction({
                validUntil: Math.floor(Date.now() / 1000) + 600,
                messages: [
                    {
                        address: this.address.toRawString(),
                        amount: (0, ton_core_1.toNano)('0.05').toString(),
                        stateInit: (0, ton_core_1.beginCell)()
                            .store((0, StateInit_1.storeStateInit)(this.init))
                            .endCell()
                            .toBoc()
                            .toString('base64'),
                        payload: (0, ton_core_1.beginCell)()
                            .storeUint(0x54a94f2a, 32)
                            .storeBit(winner)
                            .endCell()
                            .toBoc()
                            .toString('base64'),
                    },
                ],
            });
        }
        else {
            await via.send({
                to: this.address,
                init: this.init,
                value: (0, ton_core_1.toNano)('0.05'),
                body: (0, ton_core_1.beginCell)()
                    .storeUint(0x54a94f2a, 32)
                    .storeBit(winner)
                    .endCell(),
            });
        }
    }
    async runGetMethod(method, stack) {
        var res;
        if (this.executor) {
            res = await this.executor.get(method);
            if (!res.success)
                throw res.error;
        }
        else {
            res = await this.client.callGetMethod(this.address, method, stack);
        }
        return res.stack;
    }
    async getTotalBets() {
        const t = await this.runGetMethod('get_total_bets');
        return [t.readBigNumber(), t.readBigNumber()];
    }
    async getStartedFinished() {
        const t = await this.runGetMethod('get_started_finished');
        return [t.readBoolean(), t.readBoolean()];
    }
    async getWinner() {
        return (await this.runGetMethod('get_winner')).readBoolean();
    }
    static async getCode() {
        let result = await (0, func_js_1.compileFunc)({
            targets: ['stdlib.fc', 'opcodes.fc', 'event.fc'],
            sources: (path) => (0, fs_1.readFileSync)('func/' + path).toString(),
        });
        if (result.status === 'error') {
            throw result.message;
        }
        return ton_core_1.Cell.fromBoc(Buffer.from(result.codeBoc, 'base64'))[0];
    }
    static async getStateInit(oracle, uid) {
        return {
            code: await this.getCode(),
            data: (0, ton_core_1.beginCell)()
                .storeUint(uid, 128)
                .storeAddress(oracle)
                .storeUint(0, 515)
                .storeRef(await Bet_1.Bet.getCode())
                .endCell(),
        };
    }
    // retrieve existing contract from blockchain
    static async getInstance(client, address) {
        const contractState = await client.getContractState(address);
        if (!contractState || !contractState.code || !contractState.data)
            throw new Error('Contract not found');
        const init = {
            code: ton_core_1.Cell.fromBoc(contractState.code)[0],
            data: ton_core_1.Cell.fromBoc(contractState.data)[0],
        };
        const contract = new Event(address, init, client);
        return new Event(contract.address, contract.init, client);
    }
}
exports.Event = Event;
function cell_hash(state_init) {
    throw new Error('Function not implemented.');
}
