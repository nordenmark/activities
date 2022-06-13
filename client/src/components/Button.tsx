/** @jsxImportSource @emotion/react */
import React from 'react';
import * as css from './button.styles';

export type ButtonKind = 'primary' | 'discreet';

export interface ButtonProps {
  kind?: ButtonKind;
}

export const Button = React.forwardRef<
  HTMLButtonElement,
  React.ButtonHTMLAttributes<HTMLButtonElement> & ButtonProps
>((props, ref) => {
  const { kind, ...propList } = props;

  return (
    <button ref={ref} {...propList} css={css.button(kind ?? 'primary')}>
      {props.children}
    </button>
  );
});

Button.defaultProps = {
  kind: 'primary',
};
