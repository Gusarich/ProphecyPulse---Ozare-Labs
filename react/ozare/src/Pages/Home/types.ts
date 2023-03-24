export interface MatchesResponseType {
  Stages: Array<{
    Events: Array<{
      Eid: string | number;
      [key: string]: any;
    }>;
    [key: string]: any;
  }>;
}

export type MatchesProps = {
  data: MatchesResponseType;
  category: string;
};
