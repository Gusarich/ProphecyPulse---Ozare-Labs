import axios from 'axios';
import { keyPairFromSecretKey } from 'ton-crypto/dist/index';
import {
  TonClient,
  WalletContractV3R2,
} from 'ton/dist/index';

import { Event } from '../wrappers/Event';
import {
  Category,
  getAllMatchesByDate,
  getMatchDetails,
  getMatchStatus,
} from '../wrappers/Livescore';

async function main () {
    // create 
    const client = new TonClient({
        endpoint: 'https://toncenter.com/api/v2/jsonRPC',
        apiKey: 'YOUR_API_KEY'
    })

    const keypair = keyPairFromSecretKey(Buffer.from('1234abcd'))

    const wallet = WalletContractV3R2.create({
        workchain: 0,
        publicKey: keypair.publicKey
    })

    const sender = wallet.sender(
        client.provider(wallet.address, wallet.init),
        keypair.secretKey
    )

    // Deploy new Event contract
    const event = await Event.create(client, wallet.address, 123)
    await event.deploy(sender)

    // Get the Event address
    const addr = event.address
    
    const category = Category.basketball;

    const allMatches = await getAllMatchesByDate("20230312", category)

    if (allMatches) {
      const matchEid = allMatches.Stages[0].Events[0].Eid as string;
      const matchStatus = await getMatchStatus(matchEid, category);

      // Can call contract functions like distributing to accurate pool members
    }

    // Start event
    await event.startEvent(sender)

    // Finish event
    // result is boolean (true/false)
    // false => outcome 0
    // true => outcome 1
    const result: boolean = false // outcome 0
    await event.finishEvent(sender, result)
}

main()