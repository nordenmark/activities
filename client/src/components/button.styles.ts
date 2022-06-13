import { css } from '@emotion/react';
import { Colors } from '../theme';
import { ButtonKind } from './Button';

const perKind = {
  primary: css({
    backgroundColor: Colors.PRIMARY,
    color: 'white',
    '&:hover': {
      backgroundColor: Colors.PRIMARY,
    },
    '&:active': {
      backgroundColor: Colors.PRIMARY,
    },
    '& a': {
      color: 'white',
      textDecoration: 'none',
    },
  }),

  discreet: css({
    backgroundColor: 'transparent',
    color: Colors.PRIMARY,
    '&:hover': {
      backgroundColor: 'transparent',
    },
  }),
};

export const button = (kind: ButtonKind) => {
  const kindStyles = perKind[kind];

  return css(kindStyles, {
    display: 'inline-flex',
    alignItems: 'center',
    justifyContent: 'center',
    gap: '$default',
    padding: '$default $large',
    fontFamily: '$action',
    fontWeight: '$action',
    fontSize: '$action',
    border: 'none',
    borderRadius: '$small',
    cursor: 'pointer',
    transition: `transform 0.1s ease-in`,
    '&:active': {
      transform: 'scale(0.98)',
    },
    '&[disabled]': {
      backgroundColor: '$textLight',
      color: '$text',
      cursor: 'not-allowed',
      '&:active': {
        transform: 'none',
      },
      '& a': {
        color: '$text',
        textDecoration: 'none',
        pointerEvents: 'none',
      },
    },
  });
};
