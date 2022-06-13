import React from 'react';

export interface ColumnProps {
  justifyContent?:
    | 'flex-start'
    | 'flex-end'
    | 'center'
    | 'space-between'
    | 'space-around';

  alignItems?: 'flex-start' | 'flex-end' | 'center' | 'stretch' | 'baseline';

  gap?: number | string;
}

export const Column = React.forwardRef<
  HTMLDivElement,
  React.DetailedHTMLProps<
    React.HTMLAttributes<HTMLDivElement>,
    HTMLDivElement
  > &
    ColumnProps
>(({ children, justifyContent, alignItems, gap, ...props }, ref) => {
  return (
    <div
      ref={ref}
      {...props}
      style={{
        display: 'flex',
        flexDirection: 'column',
        alignItems,
        justifyContent,
        gap,
      }}
    >
      {children}
    </div>
  );
});

Column.defaultProps = {
  justifyContent: 'flex-start',
  alignItems: 'flex-start',
  gap: 0,
};

export default Column;
