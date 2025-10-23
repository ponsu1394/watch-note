package model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

public class ViewedWork implements Serializable{
	private int id;
	private String title;
	private LocalDateTime updatedAt;
    private int starId;
    private String review;
    private String starLabel;

    
    private List<String> genres;

    public List<String> getGenres() {
        return genres;
    }
    public void setGenres(List<String> genres) {
        this.genres = genres;
    }
    
    private String starName;

    public String getStarName() {
        return starName;
    }
    public void setStarName(String starName) {
        this.starName = starName;
    }
    
    public String getStarLabel() {
        return starLabel;
    }
    
    public void setStarLabel(String starLabel) {
        this.starLabel = starLabel;
    }


    
    public ViewedWork() {
    	
    }

	public ViewedWork(int id, String title, LocalDateTime updatedAt, int starId, String review) {
		this.id = id;
		this.title = title;
		this.updatedAt = updatedAt;
		this.starId = starId;
		this.review = review;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}

	public int getStarId() {
		return starId;
	}

	public void setStarId(int starId) {
		this.starId = starId;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}
    
    
}
