
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

CALL CreateDoctor('doctor1', 'ON', 'Toronto', 'M1P5C5', '321 Lester', 'Andrew', 'Chung', NOW(), 'male', 'pediatrician,nutritionist,surgeon');
CALL CreateDoctor('doctor2', 'ON', 'Toronto', 'M1P5C5', '321 Lester', 'Andrew', 'Chung', NOW(), 'male', 'surgeon');
CALL CreateDoctor('doctor3', 'ON', 'Toronto', 'M1P5C5', '321 Lester', 'Andrew', 'Chung', NOW(), 'male', 'pediatrician,nutritionist,surgeon,botanist,neuro,pychiatrist');
CALL CreateDoctor('doctor4', 'ON', 'Vaughan', 'M1P5C5', '321 Lester', 'Andrew', 'Chung', NOW(), 'male', 'pediatrician,nutritionist,surgeon,botanist,neuro,pychiatrist');

SELECT COUNT(*) FROM doctor;
SELECT COUNT(address_id) FROM doctor;
SELECT COUNT(*) FROM doctor_specialization d WHERE d.alias = 'doctor1';


CALL CreateDoctor('doctor1', 'ON', 'Toronto', 'M1P5C5', '321 Lester', 'Andrew', 'Chung', NOW(), 'male', 'pediatrician,nutritionist,surgeon');








