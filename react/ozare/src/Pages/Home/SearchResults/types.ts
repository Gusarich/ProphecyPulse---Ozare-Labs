export interface Team {
  entity: {
    country: {
      alpha2: string;
      name: string;
    };
    disabled: boolean;
    gender: string;
    id: number;
    name: string;
    nameCode: string;
    national: boolean;
    shortName: string;
    slug: string;
    sport: {
      id: number;
      name: string;
      slug: string;
    };
    teamColors: {
      primary: string;
      secondary: string;
      text: string;
    };
    type: number;
    userCount: number;
  };
  score: number;
  type: string;
}
