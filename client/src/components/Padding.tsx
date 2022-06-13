import React from 'react';

export interface PaddingProps {
  only?: {
    top?: number;
    right?: number;
    bottom?: number;
    left?: number;
  };
  symmetrical?: {
    vertical?: number;
    horizontal?: number;
  };
  all?: number;
  fromTRBL?: [number, number, number, number];
}

const style = (props: PaddingProps) => {
  const { only, fromTRBL, all, symmetrical } = props;

  let [paddingLeft, paddingRight, paddingTop, paddingBottom] = [0, 0, 0, 0];

  if (all) {
    return {
      padding: all,
    };
  }

  if (only) {
    paddingTop = only.top || 0;
    paddingRight = only.right || 0;
    paddingBottom = only.bottom || 0;
    paddingLeft = only.left || 0;

    return {
      paddingTop,
      paddingRight,
      paddingBottom,
      paddingLeft,
    };
  }

  if (fromTRBL) {
    [paddingTop, paddingRight, paddingBottom, paddingLeft] = fromTRBL;
  }

  if (symmetrical) {
    [paddingLeft, paddingRight] = [
      symmetrical.horizontal ?? 0,
      symmetrical.horizontal ?? 0,
    ];

    [paddingTop, paddingBottom] = [
      symmetrical.vertical ?? 0,
      symmetrical.vertical ?? 0,
    ];
  }

  return {
    paddingLeft,
    paddingRight,
    paddingTop,
    paddingBottom,
  };
};

export const Padding = React.forwardRef<
  HTMLDivElement,
  React.DetailedHTMLProps<
    React.HTMLAttributes<HTMLDivElement>,
    HTMLDivElement
  > &
    PaddingProps
>(({ children, only, fromTRBL, all, symmetrical, ...props }, ref) => {
  return (
    <div
      style={style({
        only,
        fromTRBL,
        all,
        symmetrical,
      })}
      ref={ref}
      {...props}
    >
      {children}
    </div>
  );
});

export default Padding;
