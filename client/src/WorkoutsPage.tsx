/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import React, { FC } from 'react';
import { useQuery } from 'react-query';
import { useApiClient } from './api';
import Column from './components/Column';
import Page from './Page';
import { WorkoutCard } from './WorkoutCard';

const styles = {
  list: css({
    width: 400,
    maxWidth: '90%',
  }),
};

export const WorkoutsPage: FC = () => {
  const api = useApiClient();
  const query = useQuery('workouts', api.workouts);

  if (query.isLoading) {
    return <div>loading...</div>;
  }

  if (query.isError) {
    return <div>error...</div>;
  }

  const workouts = query.data!;

  return (
    <Page>
      <h1>Workouts</h1>

      <div css={styles.list}>
        <Column gap={4}>
          {workouts.map(workout => (
            <WorkoutCard key={workout.id} workout={workout} />
          ))}
        </Column>
      </div>
    </Page>
  );
};

export default WorkoutsPage;
