import {
  faDoorClosed,
  faRunning,
  IconDefinition,
} from '@fortawesome/free-solid-svg-icons'; // import the icons you need
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'; // Import the FontAwesomeIcon component
import Link from 'next/link';
import { useRouter } from 'next/router';
import { useContext } from 'react';
import UserContext from '../data/user-context';
import styles from './navigation.module.scss';

export interface NavItem {
  title: string;
  icon: IconDefinition;
  action: string | (() => void);
}

function NavigationItem({ item }: { item: NavItem }) {
  const router = useRouter();

  const body = (
    <div>
      <FontAwesomeIcon size="lg" icon={item.icon}></FontAwesomeIcon>
      <span>{item.title}</span>
    </div>
  );

  const wrapper =
    typeof item.action === 'string' ? (
      <Link href={item.action}>{body}</Link>
    ) : (
      <a onClick={item.action}>{body}</a>
    );

  const isActive = router.pathname === item.action;

  return (
    <div
      className={
        isActive
          ? [styles.listItem, styles.listItemActive].join(' ')
          : styles.listItem
      }
    >
      {wrapper}
    </div>
  );
}

const Menu = ({ items }: { items: NavItem[] }) => {
  return (
    <div className={styles.menu}>
      {items.map((item) => (
        <NavigationItem key={item.title} item={item}></NavigationItem>
      ))}
    </div>
  );
};

export default function Navigation() {
  const { logout } = useContext(UserContext);

  const navItems: NavItem[] = [
    {
      title: 'Workouts',
      icon: faRunning,
      action: '/workouts',
    },
    {
      title: 'Logout',
      icon: faDoorClosed,
      action: () => {
        logout();
      },
    },
  ];

  return (
    <footer className={styles.footer}>
      {navItems.map((item) => (
        <NavigationItem key={item.title} item={item}></NavigationItem>
      ))}
    </footer>
  );
}
