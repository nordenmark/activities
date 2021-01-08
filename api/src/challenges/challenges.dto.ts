import { ChallengeType } from '#app/models/challenge.model';
import {
  IsBoolean,
  IsEnum,
  IsISO8601,
  IsNotEmpty,
  IsOptional,
  IsString,
} from 'class-validator';

export class CreateChallengeDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsISO8601()
  fromDate: string;

  @IsISO8601()
  toDate: string;

  @IsEnum(ChallengeType)
  @IsOptional()
  type: ChallengeType = ChallengeType.DAILY;
}

export class ToggleChallengeProgressDto {
  @IsBoolean()
  completed: boolean;

  @IsISO8601()
  date: string;
}
