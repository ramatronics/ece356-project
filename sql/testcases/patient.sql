CALL CreatePatient ('uesenthi','Ontario','toronto','umesh','senthil','us@gmail.com');
CALL CreatePatient ('ramietronics','Ontario','toronto','ramie','ramie','ram@gmail.com');
CALL CreatePatient ('alexo','Ontario','missassuaga','alex','ohn','alex@gmail.com');
CALL CreatePatient ('gourave','Alberta','toronto','gourave','g','g@gmail.com');
CALL CreatePatient ('samin','Ontario','Vaughan','samin','s','s@gmail.com');
CALL CreatePatient ('steven','Ontario','toronto','steven','m','s@gmail.com');
SELECT COUNT(*) FROM patient;
SELECT COUNT(address_id) FROM patient;

CALL CreatePatient ('alexo','Alberta','Manitoba','alex','jack','alex@gmail.com');
SELECT COUNT(*) FROM patient;

CALL AddFriend('uesenthi', 'ramietronics');
SELECT COUNT(*) FROM patient_friends;
CALL AddFriend('alexo', 'ramietronics');
SELECT COUNT(*) FROM patient_friends;
CALL AddFriend('uesenthi', 'ramietronics');
SELECT COUNT(*) FROM patient_friends;

CALL AddFriend('ramietronics', 'uesenthi');
CALL AddFriend('ramietronics', 'alexo');
CALL AddFriend('ramietronics', 'gourave');
CALL AddFriend('alexo', 'gourave');
CALL AddFriend('gourave', 'uesenthi');
SELECT COUNT(*) FROM patient_friends;

CALL AddFriend('gourave', 'samin');
CALL AddFriend('steven', 'gourave');
SELECT COUNT(*) FROM patient_friends;
CALL AddFriend('gouraves', 'uesenthi');


CALL ViewFriendRequests('gourave');
CALL ViewFriendRequests('uesenthi');
CALL ViewFriendRequests('steven');
CALL ViewFriendRequests('ramietronics');
CALL CreatePatient ('john','Ontario','toronto','steven','m','s@gmail.com');
CALL ViewFriendRequests('john');

CALL ViewFriends('uesenthi');
CALL ViewFriends('alexo');
CALL ViewFriends('ramietronics');
CALL ViewFriends('samin');
CALL ViewFriends('gourave');
CALL ViewFriends('steven');
CALL ViewFriends('john');

CALL AreFriends('uesenthi','ramietronics', @friend);
SELECT @friend;
CALL AreFriends('ramietronics','alexo', @friend);
SELECT @friend;
CALL AreFriends('uesenthi','alexo', @friend);
SELECT @friend;
CALL AreFriends('samin','uesenthi', @friend);
SELECT @friend;
CALL AreFriends('samin','gourave', @friend);
SELECT @friend;
CALL AreFriends('steven','gourave', @friend);
SELECT @friend;
CALL AddFriend('gourave', 'steven');
CALL AreFriends('steven','gourave', @friend);
SELECT @friend;
CALL ViewFriends('steven');

CALL PatientSearch('uesenthi','Ontario', 'Toronto');
CALL PatientSearch('steven','Ontario', 'Toronto');

CALL PatientSearch('Uesenthi','Ontario', 'Toronto');
CALL PatientSearch('alexo','Ontario', 'Toronto');
CALL PatientSearch('gabe','Ontario', 'Toronto');

CALL PatientSearch('samin','ontario', 'Vaughan');
CALL CreateReview('uesenthi','doctor1',2.5, 'Hes a good guy');
CALL PatientSearch('uesenthi','Ontario', 'Toronto');
CALL PatientSearch('uesenthii','Ontario', 'Toronto');
CALL PatientSearch('gourave','Alberta', 'Toronto');
CALL CreateReview('gourave','doctor1',5, 'Hes a good guy');
CALL PatientSearch('gourave','Alberta', 'Toronto');