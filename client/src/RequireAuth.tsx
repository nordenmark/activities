import { FC } from 'react';
import { useRecoilValue } from 'recoil';
import LoginPage from './LoginPage';
import { authIsLoggedIn } from './state';

interface Props {
  children?: React.ReactNode;
}

const RequireAuth: FC<Props> = ({ children }) => {
  const isLoggedIn = useRecoilValue(authIsLoggedIn);

  if (!isLoggedIn) {
    return <LoginPage />;
  }

  return <div>{children}</div>;
};

export default RequireAuth;
