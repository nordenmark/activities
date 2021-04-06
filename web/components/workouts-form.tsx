import { format } from 'date-fns';
import { FormEvent, useState } from 'react';

export default function WorkoutsForm({
  onSubmit,
  activities,
}: {
  onSubmit: Function;
  activities: string[];
}) {
  const [activity, setActivity] = useState(
    activities.length > 0 ? activities[0] : '',
  );
  const [date, setDate] = useState(new Date());

  const onFormSubmit = (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    onSubmit(date, activity);
  };

  return (
    <form onSubmit={onFormSubmit} className="form">
      <div className="form-group">
        <label className="form-label" htmlFor="date">
          Date
        </label>
        <input
          value={format(date, 'yyyy-MM-dd')}
          onChange={(e) => setDate(new Date(e.target.value))}
          type="date"
          className="form-control"
          id="date"
        />
      </div>

      <div className="form-group">
        <label className="form-label" htmlFor="activity">
          Activity
        </label>
        <input
          value={activity}
          onChange={(e) => setActivity(e.target.value)}
          type="text"
          className="form-control"
          id="activity"
        />
      </div>

      <div className="tag-cloud">
        {activities.map((activity) => (
          <div
            key={activity}
            className="tag"
            onClick={() => setActivity(activity)}
          >
            {activity}
          </div>
        ))}
      </div>

      <button disabled={!date || !activity} type="submit">
        Save
      </button>
    </form>
  );
}
