import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faRunning } from '@fortawesome/free-solid-svg-icons';
import { format } from 'date-fns';

import { WorkoutModel } from '../lib/api';

import styles from './workout.module.scss';

export default function Workout({ workout }: { workout: WorkoutModel }) {
  return (
    <div className={styles.container}>
      <div>
        <FontAwesomeIcon size="lg" icon={faRunning}></FontAwesomeIcon>
      </div>
      <div>
        <p>{workout.activity}</p>
        <p>{format(workout.date, 'yyyy-MM-dd')}</p>
      </div>
    </div>
  );
}
