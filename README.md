# Image Processing Coding Challenge

## Caveats

I've gone for the first stretch goal and implemented the solution 
using `docker-compose`.

This was a bit of a stretch as I didn't much time available this weekend.

Since I had to save time somewhere - there are the following caveats:

* There is no validation of input parameters anywhere
* Only the happy-path of each service has been tested, tests need to be added for
  invalid parameters, All error scenarios, 404s etc.
* Tests need to be added for all upload formats and the formats white-listed.
* Tests need to be added for all conversion formats and the possible conversions white-listed.
* I haven't run a linter over the code.
* I would normally have a couple of passes of re-factoring

## Launching the app

Run `docker-compose up` from the root directory. The image service should be available on `http://localhost:3000`
## App architecture

2 services have been implemented:

### Conversion Service

The service is built as a single container, which can be launched with a different environment variable to provide a different conversion. See `docker-compose.yml`

`conversion_service` receives a POST request on `/api/convert` with a JSON payload with the following format:

```json
{
      "image_format": "jpg",
      "base64_encoded_data": "/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAMCAgICAgMCAgIDAwMDBAYEBAQEBAgGBgUGCQgKCgkICQkKDA8MCgsOCwkJDRENDg8QEBEQCgwSExIQEw8QEBD/2wBDAQMDAwQDBAgEBAgQCwkLEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBD/wAARCAAYABgDAREAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAAAwj/xAAoEAACAQMDAwMFAQAAAAAAAAABAgMEBREGByESEyIAIzEUFRZBUST/xAAWAQEBAQAAAAAAAAAAAAAAAAAAAQX/xAAlEQABAwQBBAIDAAAAAAAAAAARAQIDAAQhQRITMVFxMpEiocH/2gAMAwEAAhEDEQA/AJK1FqLden3XW12uO8fj33K3x+3Z0kpjTOqGoY1BTK4Yn9n5blekA5rGRLEVBC7+sVgxx262/Jw5Bd5OsUenNR7v1G781pu1PdBpcV9dGjyWpUh7KrL2fe7YOMhMHq545OfR7IkiKfLG6skdsltyaOQTfo4NJs/qLde7akkp9cx3gUItskh+ss6Uka1ImQKqOEBf2yTzjksMeIYp2RNb+AJ81LyO3YwxAnSnAo9R6c3fqN34btaai6DS4r6GR0juqpD2VWLvez3AcZD5HTzzwc+jHxJEF+WdVY5LZLbi4cguvYyKTTund16fddrpdJLx+PfcrhJ7l4SSmNM6uKdRTh8rhiP0fleF6SSe+JYggITX3mpJJbrb8WjkE1k7zR7N6c3fs+p6qp1/UXSS3NQPHEKq6rUp3jJGRhRI2D0h+cf0Z59Lh8TmiPv6q3sls+NEhBPgfyk1Fs/qS7brrrmnms4oRcrfWZkmmFSscCoHQKF6PIrnnJ8V5XLAmTtbFwyQtSO8Yy36SkhU0M0enNm9T2fd+bX9TX2trdJX11UIo5ZDN0TLKFGCgXI7gz5f359H3DXRdNO+Ksl7G+26KIpCfoUmz+z+pNv9SSXi8TWdoWtslH/jmmeSSRpkcO4dQB4r0+OBhV4zklPO2VoQ96l5eMuGcWnucjxX/9k="	
}
```

The service is configured by the `CONVERT_FORMAT` environment variable to convert to a specific format. For example if configured for `png`, data will be returned as follows:

```json
{
    "image_format": "png",
    "base64_encoded_data": "iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAIAAABvFaqvAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAEhklEQVQ4ywXBy6plVxUG4H9c5ly3fVKlFOnYsO8b2BAbRjihiFIGRFCbiQYhQUHs+AzijQSShg1jS0hiEFNBEMzT2AhFnTp777XmnOPi99HjX3/3epFpO5nvYallNt8nsQsvL8U64kK2t3o6NW/qJhviWMmu6tm0anFu5UjTRTNOjD4HDY9Qr042thSfY8c1MQeqqmr0XleK833xVYQmqsVLZl61TUuFQZvHWqdPfvd3Ss1iGKAyf+tn336Jps/e+9QFlEAwI159+/GG6bP3/tHTUUCdk+PVd374/P6u1pVZPHHMZVvoIQgKLSPnBZepkCpQEdOMU4CPeX5GTpFEAHCihYITvj1YVYLD0mgcebnql7dv3lq1gGuWk3c2AzrNeaCBQ/3ygK1pZMUP3vrpOS8pAWqX+y+ZDtUyy6EYWHh5+sFT6WwQG2KInAmZMTpIwciQFpitOuyjP/9VoRamdFoX3Uewx4EskOoR2tRR8FCYwVZHT0lMDoKLoTaZ9CaQxRIJKoJ1OvaWVgwL3f7qFaabFoO4FVTCfBzXmdDXqVzVpVXKa5mXvfXaD64l59Lvc5YSte87b1FGNJn5wsvI6zwo+IE4mfWJtr5O9dpaXlSrS3LcHSULrVvsatZQSy5iJKI9praewl0f5EYH/evdT4OoZlqFG27fej1q/c9f/o3nrnCGdMnHP/+eTdN///BxCkUkJVzw5Bc/uvRjpkmb3fMEV8CliYFQKoV2BOO5C4ZNsYwC30FDeB4CZAIQIZRs0UwbS/LETuwUoBQuFQY6cmJocYV7jds3bnfZUeDlauNAACwqSp4YgI11EmTnu1CTDcEzpjwIqKF6lmo0GKJdn77/dLVHM22ahZXWXMg0TQgTCHrz6H+XseuqX03x42DEgTM4AKRha+NFYhTKYUjs+TyHEeZwb9i1kvUkAAAudy9LlavTK2/fzifJ++zrKnbOkHJwX4dioUO0ZOd7dil6ut+v01IdAeVx2TfRgDdFEZXDOMpNvyanmBm6AYx1O7gmznu57JLNtAkfnAEnPlNPb1bn2SmzTD3lOshoUWXDpXz+/j8psmmsNjvim798LVK/+P1HVgiWG9Yjr7e/ed2v44s/fW4aHeNh3tz55TvvPKFqbqHczsu89XRiQGE0aPiaxx7KReAOoAHBuPZDhBsNR0BwbfdEKNloDHJiW+XODsxIwZM3f9LDm6JLbFMdw5FQ0UxHYCsTEVwCBU/e+HFnhGJUbpy+TMo2LanaigQ++eOHCnXKmpOMYMATMBNSStj5Uqey2mTWPn73byXKyLH44oExRK2PWYthOJgrMpHK1tpI+AQAZgAdUiCFoaVzeACCkQMLj9GK8gDo8W+/f35xOZVHHqP1F4VvwrPc7CPn5axGVghYHvqLZ/vaesqcC9sV21RauVzup5cnHEfILF//xtcebOtwH3lsm4CIIBp7Ey5SD7qG9Gd+nIpSIZIJNCpZcEyscy29X2o3ClU9fWXvI4KqFDuuRnVwcZ7U0tpe5xROjcijlSR3R5HKtZmfu5dSUNbIaDr/H2Tp/w1BnNelAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE5LTA3LTE1VDA5OjM2OjA4KzAwOjAwQ1XS2AAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxOS0wNy0xNVQwOTozNjowOCswMDowMDIIamQAAAAASUVORK5CYII="
}

```

### Image Service
This is the main entry point to the application. It uses MongoDB to store the data.

You can POST an image to `/api/images` with a JSON payload in the following format:

```json

{
  "image": {
    "image_format": "jpg",
    "base64_encoded_data": "/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAMCAgICAgMCAgIDAwMDBAYEBAQEBAgGBgUGCQgKCgkICQkKDA8MCgsOCwkJDRENDg8QEBEQCgwSExIQEw8QEBD/2wBDAQMDAwQDBAgEBAgQCwkLEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBD/wAARCAAYABgDAREAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAAAwj/xAAoEAACAQMDAwMFAQAAAAAAAAABAgMEBREGByESEyIAIzEUFRZBUST/xAAWAQEBAQAAAAAAAAAAAAAAAAAAAQX/xAAlEQABAwQBBAIDAAAAAAAAAAARAQIDAAQhQRITMVFxMpEiocH/2gAMAwEAAhEDEQA/AJK1FqLden3XW12uO8fj33K3x+3Z0kpjTOqGoY1BTK4Yn9n5blekA5rGRLEVBC7+sVgxx262/Jw5Bd5OsUenNR7v1G781pu1PdBpcV9dGjyWpUh7KrL2fe7YOMhMHq545OfR7IkiKfLG6skdsltyaOQTfo4NJs/qLde7akkp9cx3gUItskh+ss6Uka1ImQKqOEBf2yTzjksMeIYp2RNb+AJ81LyO3YwxAnSnAo9R6c3fqN34btaai6DS4r6GR0juqpD2VWLvez3AcZD5HTzzwc+jHxJEF+WdVY5LZLbi4cguvYyKTTund16fddrpdJLx+PfcrhJ7l4SSmNM6uKdRTh8rhiP0fleF6SSe+JYggITX3mpJJbrb8WjkE1k7zR7N6c3fs+p6qp1/UXSS3NQPHEKq6rUp3jJGRhRI2D0h+cf0Z59Lh8TmiPv6q3sls+NEhBPgfyk1Fs/qS7brrrmnms4oRcrfWZkmmFSscCoHQKF6PIrnnJ8V5XLAmTtbFwyQtSO8Yy36SkhU0M0enNm9T2fd+bX9TX2trdJX11UIo5ZDN0TLKFGCgXI7gz5f359H3DXRdNO+Ksl7G+26KIpCfoUmz+z+pNv9SSXi8TWdoWtslH/jmmeSSRpkcO4dQB4r0+OBhV4zklPO2VoQ96l5eMuGcWnucjxX/9k="
  }
}
```

A successful response will return:
```json
{
    "status": "ok",
    "id": "5d2c4b8a90d2830001595c24"
}
```

You can retrieve the image with a GET request to `/api/images/5d2c4b8a90d2830001595c24`.

You can also add an extension to convert the format. 

In the example above, GET `/api/images/5d2c4b8a90d2830001595c24.jpg` will return the stored image.

When the requested format is different, `image_service` will call out to the appropriate service to convert the data.

For example  GET `/api/images/5d2c4b8a90d2830001595c24.png` will call the `conversion_service` on `http://png/api/convert` and return the converted
data in the same format.
