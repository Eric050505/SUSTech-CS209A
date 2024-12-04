package com.example.DTO;

import com.example.Model.User;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Getter
@Setter
public class UserDTO {
    private Integer userId;
    private String displayName;
    private Integer reputation;
    private String profileImage;
    private Date creationDate;
    private List<String> badgeCounts;

    public UserDTO(User user, List<String> badgeCounts) {
        this.userId = user.getUserId();
        this.displayName = user.getDisplayName();
        this.reputation = user.getReputation();
        this.profileImage = user.getProfileImage();
        this.creationDate = user.getCreationDate();
        this.badgeCounts = badgeCounts;
    }
}
