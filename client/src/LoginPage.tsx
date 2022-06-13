import React, { FC } from 'react';
import { SubmitHandler, useForm } from 'react-hook-form';
import { useMutation } from 'react-query';
import { useSetRecoilState } from 'recoil';
import { useApiClient } from './api';
import Page from './Page';
import { authState, userState } from './state';

type Inputs = {
  email: string;
  password: string;
};

export const LoginPage: FC = () => {
  const setAuthState = useSetRecoilState(authState);
  const setUserState = useSetRecoilState(userState);
  const { register, handleSubmit } = useForm<Inputs>();
  const api = useApiClient();
  const mutation = useMutation(api.login, {
    onSuccess: response => {
      setAuthState({
        isLoading: false,
        isLoggedIn: true,
        accessToken: response.accessToken,
        accessTokenExpiresAt: Date.now() + response.accessTokenExpiresIn * 1000,
        refreshToken: response.refreshToken,
      });
      setUserState(response.user);
    },
  });

  const onSubmit: SubmitHandler<Inputs> = data => {
    mutation.mutate(data);
  };

  return (
    <Page>
      <h1>Login</h1>

      <form onSubmit={handleSubmit(onSubmit)}>
        <div>
          <input
            type="email"
            defaultValue="nordenmark@gmail.com"
            {...register('email', { required: true })}
          />
        </div>
        <div>
          <input
            type="password"
            defaultValue="ryssland"
            {...register('password', { required: true })}
          />
        </div>
        <input type="submit" value="Login" disabled={false} />
      </form>
    </Page>
  );
};

export default LoginPage;
