import { config } from '@fortawesome/fontawesome-svg-core';
import '@fortawesome/fontawesome-svg-core/styles.css'; // import Font Awesome CSS
import '@fontsource/montserrat'; // Defaults to weight 400.
import '@fontsource/quicksand'; // Italic variant.
import App from 'next/app';
import Router from 'next/router';
import UserContext from '../data/user-context';
import apiService from '../lib/api';
import { StorageService } from '../lib/storage';
import { AppState } from '../state/app.interfaces';
import '../styles/global.scss';

config.autoAddCss = false; // Tell Font Awesome to skip adding the CSS automatically since it's being imported above

const initialState: AppState = {
  user: null,
  accessToken: null,
  refreshToken: null,
  accessTokenExpiresAt: null,
  refreshTokenExpiresAt: null,
};

export default class ActivitiesApp extends App {
  state: AppState = initialState;

  componentDidMount = () => {
    const state = StorageService.getState();

    if (!state) {
      Router.push('/login');
    } else {
      this.setState(state);
    }
  };

  login = async (username: string, password: string) => {
    const response = await apiService.login(username, password);

    const state: AppState = {
      user: response.user,
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
      accessTokenExpiresAt: Date.now() + response.accessTokenExpiresIn * 1000,
      refreshTokenExpiresAt: Date.now() + response.refreshTokenExpiresIn * 1000,
    };

    StorageService.setState(state);

    this.setState(state, () => {
      Router.push('/');
    });
  };

  logout = () => {
    console.log('logout');
    StorageService.clear();
    this.setState(initialState);
    Router.push('/login');
  };

  render() {
    const { Component, pageProps } = this.props;

    return (
      <UserContext.Provider
        value={{
          user: this.state.user,
          login: this.login,
          logout: this.logout,
        }}
      >
        <Component {...pageProps} />
      </UserContext.Provider>
    );
  }
}
