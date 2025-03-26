class Logger {
  constructor() {
    this.levels = ["debug", "info", "warn", "error"];

    this.currentLevel = "debug";
  }

  setLevel(level) {
    if (this.levels.includes(level)) {
      this.currentLevel = level;
    } else {
      console.error(`Invalid log level: ${level}`);
    }
  }

  log(level, message) {
    const levelIndex = this.levels.indexOf(level);

    const currentLevelIndex = this.levels.indexOf(this.currentLevel);

    if (levelIndex >= currentLevelIndex) {
      const timestamp = new Date().toISOString();

      console[level](`[${level.toUpperCase()}] ${timestamp}: ${message}`);
    }
  }

  debug(message) {
    this.log("debug", message);
  }

  info(message) {
    this.log("info", message);
  }

  warn(message) {
    this.log("warn", message);
  }

  error(message) {
    this.log("error", message);
  }
}

const logger = new Logger();

export default logger;
