import Head from 'next/head';
import { FormEvent, useContext, useState } from 'react';
import GuestLayout from '../components/guest-layout';
import UserContext from '../data/user-context';

export default function Login() {
  const { login } = useContext(UserContext);
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const onLoginSubmit = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    login(email, password);
  };

  return (
    <GuestLayout>
      <Head>
        <title>Login</title>
      </Head>

      <h1>Login</h1>

      <form onSubmit={onLoginSubmit} className="form">
        <div className="form-group">
          <label className="form-label" htmlFor="email">
            Email address
          </label>
          <input
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            type="email"
            className="form-control"
            id="email"
          />
        </div>
        <div className="form-group">
          <label className="form-label" htmlFor="password">
            Password
          </label>
          <input
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            type="password"
            className="form-control"
            id="password"
          />
        </div>

        <button type="submit">Login</button>
      </form>
    </GuestLayout>
  );
}
