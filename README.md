# PolyBuddies

Hardware requirment: None

Milestones I planned:
    I set up five milestones:
        1. Design Firebase Model
        2. View all the teams in the Firebase
        3. Post a team to the Firebase
        4. Display teams on a map
        5. Users authetication

I have finished the first four milestones.

First milestone:

    Firebase Page:
    I design two main JSONs. In order to fattern the database, I used unique keys for users what is linked by teammember field in a team.

    Teams : {
        <name>:{
            AvailableDates
            Location
            Name
            Phone Number
            SKill Level
            Sport Type
            StartTime
            Teammember: <unique to the Users' JSON>
        }
    }

    User: {
        <unique key>:{
            Email
            First Name
            Last Name
            Skill Level
            Sport Type
        }    
    }

Second to fourth milestones:

    Each pages:

        "Post a team" Page:
            It allows a person to post a team to the Firebase.
            User first need to enter the general the description of their teams, and the app will direct the user to a page where they add teammembers.

        "Show Teams" Page:
            It shows all the available teams. The users can view the detail of a team and can add a person to the team.

        "Map" Page:
            It shows that all teams based all the fields or gyms they will be in.
