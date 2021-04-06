import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faTimes } from '@fortawesome/free-solid-svg-icons';

import styles from './modal.module.scss';
import { MouseEvent } from 'react';

export default function Modal({
  onClose,
  children,
}: {
  onClose: Function;
  children: React.ReactNode;
}) {
  const handleClickOutside = (event: MouseEvent<HTMLDivElement>) => {
    if (
      'className' in event.target &&
      // @ts-ignore
      event.target.className &&
      // @ts-ignore
      event.target.className.includes &&
      // @ts-ignore
      event.target.className.includes('backdrop')
    ) {
      onClose();
    }
  };

  return (
    <div onClick={handleClickOutside} className={styles.backdrop}>
      <div className={styles.container}>
        <div className={styles.close}>
          <FontAwesomeIcon
            onClick={() => onClose()}
            size="2x"
            icon={faTimes}
          ></FontAwesomeIcon>
        </div>
        {children}
      </div>
    </div>
  );
}
