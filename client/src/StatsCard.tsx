/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { FC } from 'react';
import Column from './components/Column';
import Padding from './components/Padding';
import { Colors } from './theme';

interface Props {
  label: string;
  value: number;
  unit?: string;
}

const styles = {
  container: css({
    background: Colors.PRIMARY,
    color: 'white',
    border: `1px solid ${Colors.BORDER}`,
  }),
};

export const StatsCard: FC<Props> = ({ label, value, unit }) => {
  return (
    <div css={styles.container}>
      <Padding all={20}>
        <Column>
          <h1>{value}</h1>
          <p>{label}</p>
        </Column>
      </Padding>
    </div>
  );
};
