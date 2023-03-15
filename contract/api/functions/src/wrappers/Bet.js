"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Bet = void 0;
const ton_core_1 = require("ton-core");
const func_js_1 = require("@ton-community/func-js");
const fs_1 = require("fs");
class Bet {
    address;
    executor;
    client;
    constructor(address, executor) {
        this.address = address;
        if ('get' in executor) {
            this.executor = executor;
        }
        else {
            this.client = executor;
        }
    }
    async close(via) {
        await via.send({
            to: this.address,
            value: (0, ton_core_1.toNano)('0.25'),
            body: (0, ton_core_1.beginCell)().storeUint(0x12d4de36, 32).endCell(),
        });
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
    async getOwner() {
        return (await this.runGetMethod('get_owner')).readAddress();
    }
    async getEvent() {
        return (await this.runGetMethod('get_event')).readAddress();
    }
    async getOutcome() {
        return (await this.runGetMethod('get_outcome')).readBoolean();
    }
    async getAmount() {
        return (await this.runGetMethod('get_amount')).readBigNumber();
    }
    static async getCode() {
        let result = await (0, func_js_1.compileFunc)({
            targets: ['stdlib.fc', 'opcodes.fc', 'bet.fc'],
            sources: (path) => (0, fs_1.readFileSync)('func/' + path).toString(),
        });
        if (result.status === 'error') {
            throw result.message;
        }
        return ton_core_1.Cell.fromBoc(Buffer.from(result.codeBoc, 'base64'))[0];
    }
    static async getStateInit(owner, event, outcome, amount) {
        return {
            code: await this.getCode(),
            data: (0, ton_core_1.beginCell)()
                .storeAddress(owner)
                .storeAddress(event)
                .storeBit(outcome)
                .storeUint(amount, 256)
                .endCell(),
        };
    }
}
exports.Bet = Bet;
