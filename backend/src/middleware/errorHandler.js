const errorHandler = (err, req, res, next) => {
  console.error(`${req.method} ${req.originalUrl}:`, err.message);

  if (res.headersSent) {
    return next(err);
  }

  let statusCode = err.statusCode || err.status || 500;
  let message = err.message || "Internal server error";

  // Invalid JSON sent in the request body
  if (err instanceof SyntaxError && err.status === 400 && "body" in err) {
    statusCode = 400;
    message = "Invalid JSON request body";
  }

  // Mongoose validation errors
  if (err.name === "ValidationError" || err.name === "CastError") {
    statusCode = 400;
    message = "Invalid request data";
  }

  // Duplicate unique field
  if (err.code === 11000) {
    statusCode = 409;
    message = "A record with this value already exists";
  }

  if (statusCode >= 500) {
    message = "Internal server error";
  }

  return res.status(statusCode).json({
    success: false,
    message,
  });
};

module.exports = errorHandler;