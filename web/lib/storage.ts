import { AppState } from '../state/app.interfaces';

const LOCAL_STORAGE_KEY = 'activities-state';

export class StorageService {
  static setState(state: AppState) {
    localStorage.setItem(LOCAL_STORAGE_KEY, JSON.stringify(state));
  }

  static getState(): AppState | null {
    const json = localStorage.getItem(LOCAL_STORAGE_KEY);

    if (!json) {
      return null;
    }

    try {
      return JSON.parse(json);
    } catch {
      StorageService.clear();
      return null;
    }
  }

  static clear() {
    localStorage.removeItem(LOCAL_STORAGE_KEY);
  }
}
