export interface Payload {
  type: string;
  uid: number; // event id
  outcome?: string;
  amount?: number;
  address?: string; // address of the contract
  result?: boolean; // winner of the event
}
export interface Response {
  status: string;
  message: string;
  data?: any;
}
