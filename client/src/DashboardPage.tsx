/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import React, { FC } from 'react';
import { useQuery } from 'react-query';
import { StatsCard } from './StatsCard';
import { useApiClient } from './api';
import Page from './Page';

const styles = {
  container: css({
    display: 'flex',
    width: '100%',
  }),
};

export const DashboardPage: FC = () => {
  const apiClient = useApiClient();
  const query = useQuery('workouts', apiClient.workouts);

  if (query.isLoading) {
    return <div>loading...</div>;
  }

  if (query.isError) {
    return <div>error...</div>;
  }

  const workouts = query.data!;

  const countThisYear = workouts.filter(
    ({ date }) => new Date(date).getFullYear() === new Date().getFullYear()
  ).length;

  const cards: Array<{ label: string; value: number; unit?: string }> = [
    {
      label: 'Total count',
      value: countThisYear,
    },
  ];

  return (
    <Page>
      <h1>Dashboard</h1>

      <div css={styles.container}>
        {cards.map(card => (
          <StatsCard key={card.value} {...card} />
        ))}
      </div>
    </Page>
  );
};

export default DashboardPage;
