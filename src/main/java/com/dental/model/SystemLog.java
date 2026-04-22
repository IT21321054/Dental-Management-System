package com.dental.model;

// =======================================================================
// MODEL CLASS: SystemLog
// Encapsulates the details of system activities for auditing purposes
// =======================================================================
public class SystemLog {

    private int logId;
    private int userId;
    private String actionDescription;
    private String timestamp;

    // Default constructor
    public SystemLog() {
    }

    // Constructor for creating a new log entry
    public SystemLog(int userId, String actionDescription) {
        this.userId = userId;
        this.actionDescription = actionDescription;
    }

    // Getters and Setters
    public int getLogId() { return logId; }
    public void setLogId(int logId) { this.logId = logId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getActionDescription() { return actionDescription; }
    public void setActionDescription(String actionDescription) { this.actionDescription = actionDescription; }

    public String getTimestamp() { return timestamp; }
    public void setTimestamp(String timestamp) { this.timestamp = timestamp; }
}