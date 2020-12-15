import { IsISO8601, IsNotEmpty, IsString } from 'class-validator';

export class CreateWorkoutDto {
  @IsISO8601()
  date: string;

  @IsString()
  @IsNotEmpty()
  activity: string;
}

export class UpdateWorkoutDto {
  @IsISO8601()
  date: string;

  @IsString()
  @IsNotEmpty()
  activity: string;
}
