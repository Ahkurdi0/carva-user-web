import * as AWS from 'aws-sdk';
import { uuidv4 } from 'uuidv7';
import { ImageDirs, ImageKeys } from '../constants/images_keys';

AWS.config.update({
  accessKeyId: process.env.AWS_ACCESS_KEY,
  secretAccessKey: process.env.AWS_SECRET_KEY,
  region: 'eu-central-1',
});

import path from 'path';
import sharp from 'sharp';
import { IFile } from '../types/interfaces';
const s3 = new AWS.S3();

export const uploadImageS3 = async (
  file: IFile,
  dir?: ImageKeys,
): Promise<string> => {
  const now = +new Date();
  const uuid = uuidv4();
  const fileName = `${uuid + now}${path.extname(file.originalname)}`;

  let directory = dir ?? ImageDirs.profile;

  const resizedImageBuffer = await sharp(file.buffer)
    .resize(800)
    .jpeg({ quality: 80 })
    .toBuffer();

  const params: AWS.S3.PutObjectRequest = {
    Bucket: `${process.env.AWS_BUCKET}/${directory}`,
    Key: `${fileName}`,
    Body: resizedImageBuffer,
  };

  await s3.putObject(params).promise();

  return `${dir}/${fileName}`;
};

export const deleteImageS3 = async (imageUrl?: String): Promise<Boolean> => {
  const params: AWS.S3.DeleteObjectRequest = {
    Bucket: `${process.env.AWS_BUCKET}`,
    Key: `${imageUrl}`,
  };

  await s3.deleteObject(params).promise();

  return true;
};

export const uploadImagesToS3 = async (
  filePaths: IFile[],
  dir: ImageKeys,
): Promise<string[]> => {
  const uploadPromises = filePaths.map(async (filePath, index) => {
    const now = +new Date();
    var uuid = uuidv4();
    const ext = path.extname(filePath.originalname);
    var fileName = `${uuid + now}${ext}`;
    var params: AWS.S3.PutObjectRequest = {
      Bucket: `${process.env.AWS_BUCKET}/${dir}`,
      Key: `${fileName}`,
      Body: filePath.buffer,
    };
    const data = await s3.upload(params).promise();
    return `${dir}/${fileName}`;
  });

  return Promise.all(uploadPromises);
};
