export interface MatchInfoResponseType {
  Eps: string;
  [key: string]: any;
}
interface Country {
  alpha2: string;
  name: string;
}

interface Sport {
  id: number;
  name: string;
  slug: string;
}

interface TeamColors {
  primary: string;
  secondary: string;
  text: string;
}

interface Team {
  country: Country;
  disabled: boolean;
  gender: string;
  id: number;
  name: string;
  nameCode: string;
  national: boolean;
  shortName: string;
  slug: string;
  sport: Sport;
  subTeams: any[];
  teamColors: TeamColors;
  type: number;
  userCount: number;
}

interface Status {
  code: number;
  description: string;
  type: string;
}

interface Category {
  alpha2: string;
  flag: string;
  id: number;
  name: string;
  slug: string;
  sport: Sport;
}

interface UniqueTournament {
  category: Category;
  country: any;
  crowdsourcingEnabled: boolean;
  displayInverseHomeAwayTeams: boolean;
  hasEventPlayerStatistics: boolean;
  hasPerformanceGraphFeature: boolean;
  id: number;
  name: string;
  slug: string;
  userCount: number;
}

interface Tournament {
  category: Category;
  id: number;
  name: string;
  priority: number;
  slug: string;
  uniqueTournament: UniqueTournament;
}

interface RoundInfo {
  round: number;
}

interface Changes {
  changeTimestamp: number;
}

export interface ScheduleType {
  awayScore: any;
  awayTeam: Team;
  changes: Changes;
  customId: string;
  detailId: number;
  finalResultOnly: boolean;
  hasGlobalHighlights: boolean;
  homeScore: any;
  homeTeam: Team;
  id: number;
  roundInfo: RoundInfo;
  slug: string;
  startTimestamp: number;
  status: Status;
  time: any;
  tournament: Tournament;
  winnerCode: number;
}
