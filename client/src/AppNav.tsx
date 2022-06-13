/** @jsxImportSource @emotion/react */
import { FC } from 'react';
import { NavLink } from 'react-router-dom';
import { Row } from './components/Row';
import { css } from '@emotion/react';
import { Colors } from './theme';
import Padding from './components/Padding';
import { Button } from './components/Button';
import { useResetRecoilState } from 'recoil';
import { authState, userState } from './state';

const styles = {
  nav: css({}),
  link: css({
    borderBottom: `5px solid transparent`,
    '&.active': {
      borderColor: Colors.BORDER,
    },
  }),
};

export const AppNav: FC = () => {
  const resetAuthState = useResetRecoilState(authState);
  const resetUserState = useResetRecoilState(userState);

  const signOut = () => {
    console.log('signout');
    resetAuthState();
    resetUserState();
  };

  return (
    <Padding all={20}>
      <Row justifyContent="space-between">
        <Row gap={12}>
          <NavLink css={styles.link} to="dashboard">
            Dashboard
          </NavLink>
          <NavLink css={styles.link} to="workouts">
            Workouts
          </NavLink>
        </Row>
        <Row>
          <Button kind="discreet" onClick={signOut}>
            Log out
          </Button>
        </Row>
      </Row>
    </Padding>
  );
};

export default AppNav;
