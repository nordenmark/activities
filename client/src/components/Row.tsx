import React from 'react';

export interface RowProps {
  justifyContent?:
    | 'flex-start'
    | 'flex-end'
    | 'center'
    | 'space-between'
    | 'space-around';
  alignItems?: 'flex-start' | 'flex-end' | 'center' | 'stretch' | 'baseline';
  gap?: number;
  wrap?: boolean;
  grow?: number;
}

export const Row = React.forwardRef<
  HTMLDivElement,
  React.DetailedHTMLProps<
    React.HTMLAttributes<HTMLDivElement>,
    HTMLDivElement
  > &
    RowProps
>(
  (
    { children, alignItems, justifyContent, gap, grow, wrap, ...props },
    ref
  ) => {
    return (
      <div
        style={{
          display: 'flex',
          flexDirection: 'row',
          alignItems: alignItems ?? 'center',
          justifyContent: justifyContent,
          gap: gap ?? 0,
          flexGrow: grow ?? 0,
          flexWrap: wrap ? 'wrap' : 'nowrap',
        }}
        ref={ref}
        {...props}
      >
        {children}
      </div>
    );
  }
);

Row.defaultProps = {
  justifyContent: 'flex-start',
  alignItems: 'flex-start',
  gap: 0,
  wrap: false,
};

export default Row;
