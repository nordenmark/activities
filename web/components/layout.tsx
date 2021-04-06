import Head from 'next/head';
import Navigation from './navigation';

export default function Layout({ children }: { children: React.ReactNode }) {
  return (
    <div>
      <Head>
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className="wrapper">{children}</main>

      <Navigation></Navigation>
    </div>
  );
}
