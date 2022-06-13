import React from 'react';
import { Navigate, Route, Routes } from 'react-router-dom';
import { DashboardPage } from './DashboardPage';
import { AppNav } from './AppNav';
import WorkoutsPage from './WorkoutsPage';
import RequireAuth from './RequireAuth';

function App() {
  return (
    <RequireAuth>
      <AppNav />

      <Routes>
        <Route path="/dashboard" element={<DashboardPage />} />
        <Route path="/workouts" element={<WorkoutsPage />} />
        <Route path="" element={<Navigate to={'dashboard'} replace={true} />} />
      </Routes>
    </RequireAuth>
  );
}

export default App;
