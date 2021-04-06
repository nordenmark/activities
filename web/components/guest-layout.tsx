import Head from 'next/head';
import Image from 'next/image';
import styles from './guest-layout.module.scss';

const getIconDimensions = (width: number) => {
  const ORIGINAL_WIDTH = 700;
  const ORIGINAL_HEIGHT = 284;
  return {
    width,
    height: (width / ORIGINAL_WIDTH) * ORIGINAL_HEIGHT,
  };
};

export default function GuestLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="wrapper">
      <Head>
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <header className={styles.header}>
        <Image priority src="/images/icon.png" {...getIconDimensions(300)} />
      </header>

      <main>{children}</main>
    </div>
  );
}
