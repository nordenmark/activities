import { faPlus } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import Head from 'next/head';
import React, { useState } from 'react';
import Layout from '../components/layout';
import Modal from '../components/modal';
import WorkoutsForm from '../components/workouts-form';
import Workout from '../components/workout';
import { useWorkouts } from '../data/use-workouts';
import apiService, { WorkoutModel } from '../lib/api';

const getDistinctActivities = (workouts: WorkoutModel[]): string[] => {
  const map = new Map<string, number>();

  workouts.forEach(({ activity }) => {
    map.set(
      activity,
      map.get(activity) !== undefined ? map.get(activity) + 1 : 0,
    );
  });

  const array = Array.from(map.entries())
    .sort((a, b) => b[1] - a[1])
    .map(([activity]) => activity);

  return array.slice(0, 6);
};

export default function Workouts() {
  const { workouts, isLoading, error, mutate } = useWorkouts();
  const [modalOpen, toggleModalOpen] = useState(false);

  console.log('data', workouts);

  if (isLoading) {
    return <p>Loading...</p>;
  }

  if (error) {
    console.log('error', error);
    return <></>;
  }

  const activities = getDistinctActivities(workouts);

  const toggleModal = () => {
    toggleModalOpen(!modalOpen);
  };

  const onWorkoutCreate = (date: Date, activity: string) => {
    console.log('workoutCreate', date, activity);
    toggleModal();
    apiService.createWorkout(date, activity).then((workout) => {
      console.log('workout created', workout);
      mutate();
    });
  };

  return (
    <Layout>
      <Head>
        <title>Workouts</title>
      </Head>
      {modalOpen && (
        <Modal onClose={toggleModal}>
          <WorkoutsForm
            activities={activities}
            onSubmit={onWorkoutCreate}
          ></WorkoutsForm>
        </Modal>
      )}

      <header className="page-title">
        <h1>Workouts</h1>

        <a onClick={toggleModal}>
          <FontAwesomeIcon size="sm" icon={faPlus}></FontAwesomeIcon> Add new
        </a>
      </header>

      {workouts.map((workout) => (
        <Workout key={workout.id} workout={workout}></Workout>
      ))}
    </Layout>
  );
}
