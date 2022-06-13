/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC } from 'react';
import { Workout } from './api';
import Column from './components/Column';
import Padding from './components/Padding';
import { Colors } from './theme';

interface Props {
  workout: Workout;
}

const styles = {
  container: css({
    border: `1px solid ${Colors.BORDER}`,
    width: '100%',
  }),
};

export const WorkoutCard: FC<Props> = ({ workout }) => {
  const formattedDate = workout.date.substring(0, 10);

  return (
    <div css={styles.container}>
      <Padding all={20}>
        <Column>
          <h3>{workout.activity}</h3>
          <p>{formattedDate}</p>
        </Column>
      </Padding>
    </div>
  );
};
