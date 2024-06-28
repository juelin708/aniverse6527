package com.example.aniverseapp;

public class Response<T> {
    private T data;
    private boolean success;
    private String message;

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public static <K> Response<K> newSuccess(K data, String message) {
        Response<K> response = new Response<K>();
        response.setData(data);
        response.setSuccess(true);
        response.setMessage(message);
        return response;
    }

    public static Response<Void> newFailure(String message) {
        Response<Void> response = new Response<Void>();
        response.setSuccess(false);
        response.setMessage(message);
        return response;
    }
}
