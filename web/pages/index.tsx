import { useRouter } from 'next/router';
import { useContext, useEffect } from 'react';
import UserContext from '../data/user-context';

export default function Home() {
  const { user } = useContext(UserContext);
  const router = useRouter();

  useEffect(() => {
    console.log('user', user);
    if (!user) {
      router.push('/login');
    } else {
      router.push('/workouts');
    }
  });

  return <></>;
}
