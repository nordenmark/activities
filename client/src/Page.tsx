import React, { FC } from 'react';

export const Page: FC<JSX.IntrinsicElements['div']> = props => {
  return (
    <div style={{ padding: 20 }} {...props}>
      {props.children}
    </div>
  );
};

export default Page;
