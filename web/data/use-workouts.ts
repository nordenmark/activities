import useSWR from 'swr';
import apiService from '../lib/api';

export function useWorkouts() {
  const { data, error, mutate } = useSWR(`/workouts`, apiService.getWorkouts, {
    revalidateOnMount: true,
  });

  return {
    workouts: data,
    isLoading: !error && !data,
    error: error,
    mutate,
  };
}
