import { WithChildrenProps } from '@app/types/generalTypes';
import React from 'react';
import { Helmet } from 'react-helmet-async';

export const PageTitle: React.FC<WithChildrenProps> = ({ children }) => {
  return (
    <Helmet>
      <title>Prophecy Pulse- first decentralized prediction markets platform on telegram</title>
    </Helmet>
  );
};
