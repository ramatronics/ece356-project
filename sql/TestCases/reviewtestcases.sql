CALL CreatePatient ('uesenthi','Ontario','toronto','umesh','senthil','us@gmail.com');
CALL CreatePatient ('ramietronics','Ontario','toronto','ramie','ramie','ram@gmail.com');
CALL CreatePatient ('alexo','Ontario','missassuaga','alex','ohn','alex@gmail.com');
CALL CreatePatient ('gourave','Alberta','toronto','gourave','g','g@gmail.com');
CALL CreatePatient ('samin','Ontario','Vaughan','samin','s','s@gmail.com');
CALL CreatePatient ('steven','Ontario','toronto','steven','m','s@gmail.com');

CALL CreateDoctor('doctor1', 'ON', 'Toronto', 'M1P5C5', '321 Lester', 'Andrew', 'Chung', NOW(), 'male', 'pediatrician,nutritionist,surgeon');
CALL CreateDoctor('doctor2', 'ON', 'Toronto', 'M1P5C5', '321 Lester', 'Andrew', 'Chung', NOW(), 'male', 'surgeon');
CALL CreateDoctor('doctor3', 'ON', 'Toronto', 'M1P5C5', '321 Lester', 'Andrew', 'Chung', NOW(), 'male', 'pediatrician,nutritionist,surgeon,botanist,neuro,pychiatrist');
CALL CreateDoctor('doctor4', 'ON', 'Vaughan', 'M1P5C5', '321 Lester', 'Andrew', 'Chung', NOW(), 'male', 'pediatrician,nutritionist,surgeon,botanist,neuro,pychiatrist');

CALL CreateReview('uesenthi','doctor1',2.5, 'Hes a good guy');
CALL CreateReview('uesenthi','doctor1',3.0, 'Hes a aight');
CALL CreateReview('uesenthi','doctor1',2.4, 'Hes a good guy');
CALL CreateReview('uesenthi','doctor1',5.5, 'Hes a good guy');
CALL CreateReview('uesenthi','doctor1',-0.5, 'Hes a good guy');
CALL CreateReview('gabe','doctor1',2.5, 'Hes a good guy');
CALL CreateReview('uesenthi','doctor5',2.5, 'Hes a good guy');
CALL CreateReview('samin','doctor2',2.5, '');
CALL CreateReview('samin','doctor2',2.5);
CALL CreateReview('samin','doctor3',2.5, "He's aight");
CALL CreateReview('alexo','doctor4',2, "WB8A9qJ4RiGAWge6YyfirYrY0Oia9mWu7k8SwDgFLvnzgFdywnqnS7lSCXNUtwQhvRvxDU3jWgbkLR4mgNK9EVfk3j8qIrgMhYTnQ2DR06iEDIG6upSZtmSEHEoctXviRcRF7YMOcj4Y8dM1gC01usxieejEIlDeJ1QO8NcuyRDTeN2STklslIihJfYB8NdlUkVi9wGRkK06PTqTi7c17mjg7y58uNKkSpj3ZcHD9HMYXo7ENjAnFEzXXyJr1hhYTriLkmXfvqRVw6wGVsTBWkhI0YT2kM9zKa7TXxyYb3s7iL4q4dHAsLJMCDntPPoSPdYmHMPPZtnxT0vyI4ow4UDSuN6RsnE4a8atoQWBuwdu9m0q8AKYeFNQS1oBAFEgXL7Eb4nPBKyve3ssZBlXiDPW3jnzqar7SXlJsinOjk0HUN1Nlern7CKU5rQ0Rp9qOmW4lCrb6Xx1d78NrJSLDOBB0rr3sqFwtWGSkIn6nRB7Wza1wXVZ1g62IdM1gcmVigpiTkrgHjcNIVwxLrZAneUzyomEstppQyjR7un4Zo65bbVuLdSbHHXGEwvyBYNxMt0sT4C00IdNIfn41YhsbyaTrWvj3NU9I0mscxYgDaNGAIQc8YSd9FV0YLBxOrg800L4fmlxJRB6LDptVkzdPLiVyDo0FrfqfYp6nA8AoJJsg5SOoL4SILQHCjrqFCghCXhuHxY4ktSpSuwyUrJPnoPS16xkmJy2e5XMwXagSMjgHFqrhCv05tUOLnvvPmfg8uOPyqUncAFRvR383La9mT5SiX92VatwawLtRLS6e2M7Wvfa2X9CBreYgUxrMI79wBceYvGjiCPf0zOaikF9MDwMlFbmENCeEIG47reEmrJCuZlJ5pJVTRXBAWQt8Q68ibhVlgwtzu4K2l9ZvL0sXy49Jlt9XMl896oblVMnZLiPcd07IST0pG1y0Hn1XFwD7NcMWwyz1qbcOJJtKnPUt1AzjmaWU6JdCxvhgAS5");
CALL CreateReview('steven','doctor3',0, "Ai5HP3Nq196K4jYpWv2fXlN0icCeClK3xTttsyx08RcaO7LD61yzSai1QQCmrniW6I2GihAHqrcqWQvahoxqF73868dQdprBw0w0RH8PPMZ9fr5SUGifFAmRoZKycbB5eYp85UEDdJIYqKttOIFakoMHpkPAHES7AU2oYFD88HTIAjAPZYIJf30fPx3fk7M2bLDehHHao1RP2p2cR4OKN3yAkEdQtaDeyc0QVk6AJlrskJXsWpFcpIhFyrQIYrHzDY7mhCC22vwxiDWUDvBlvOOBrkDvqV377FIbmadRmuETfrIWMfCYZM68cGOAd72QEgtJKlKMlwCNl2RLFKXstIRN1xXiACIq0zJBdoUS1jOeff5uoepOM5y1rkqICSxgOWCNHm7vU1zjMNso0s9tGfbFtX6THctO3WxuE7KHlkovWPSbkMo6UdrKT2e3BxDvnyJ3q5hb5rnX39y98uxDYTGUF1S3pPGpFtlP2RVF91P7b2nxZcaFgcJvqYf0I2uIcJCEwAyg3A1XdmPut8nlxxiqgHf7kBwg9XEZWXrKy7mmoVPPmqoI6sZA9EvqTNSHDS7qnhMZaENqNST9BRTbqCfKGLQD7qxlZgHbRz5OuWIdB4xZEJgqG65NQqSZ6IxGHxlNkJKyNx7cP7P98EiPcufWOvu1oDLqVDe8byKUu9yLGtuBpqKuobJwAflICC2zcmegg7BdWMiBtdnylH4z6GQMDbGGfal3ysWj9SZsdFh8fOX5zu1ll7HqvA5XdsqIWAxxsB4cmGfuX5n7sj0i5gudKybTFxjyHoRbrtttrrvhC3jIgGJttlgIGrJvOk4fmVJp9Xz0ofCiKL66x5OyhsLDCf3eRloPO0lL99Z8Q5qkbFypRgug5oBryutRHyuQmLNznSwbDCxNHh5xQuCVhMONf0r009sykKtIe0Iwx9lYngEQ4D9HqXweN6xxukzAOgqYjUbNvu016VbpEZhA1adVIiYtpDm0poSVGW1TXzFXeDUaLjUiV1HgtMZT7iqn");
CALL CreateReview('steven','doctor3',0, "jnGjRSKoDSZT6XiL9GmCkLEnNkvlHT3iJiNGET9mLxekxVCt3aNqng0anYmbb0TgGR3pStrcwtuJLHIZGTXMUTyAi0x9oAr9o42SBRbFW6ZuknOLCwZ1sq7U6EpskATocWJLwrXiIrqoxu5MsmYFGpEX085wK0dOfLKfjWwtBuy3V3fKwU51BWMlt9nFXTJ19p8IDa6oraQEGa9KRwUQswGj5B0ymUK2N0QYFtX6HgDqQc5xBwd8VhcxcPz7UlaGdiOMmUl9WwpRTXmeX83fDRMk1xFUfbTxexqbvC6XQon9MXWFAOhlaZIXYNgUp9zCtoIOtqTkza7Zn0KUoc0GQAuxsKnhPl9ORQo4HjPap18Zz1nxkO8Fp2EeW6GCFX86UsCMhQScPj6veYXbs37lepGEgfDGKWqTQPvp0nhTaDwd5yxqe59uSeoNSgwZgQR2LwHAwPeGlkuRbhjrrhqAbQ1QoGXf44OlFLp1MKcI8thW6UGn9nGXvoewlIkCrAEqLS92VLc5UVhYcHW1tgqmu5uUgHHP5VkL00zNSpd4yxN69bcQeBGasHJkIPAhg4TfwU0Hgv12c2Y5cFi3RbSQQlvrKZtJx6Wu2RKF4TOTLdK7YPG11BiFh2YXf2a0H35PcjIkV1jWsd7pwAFoPOXWuVSd738PZV3LeB3xIvaohZPd9ueOuJIqiN2VxOJ6A58Io74b6l756jUNPf4WIeC1AaNwI9nDdOGhjxJYp0TxRIRdGxtGKtIJj5l5s5SXvSdhGb96M5GrWGoXAb268XucVznR6JrqumLdiFUGt0Ef6NXRjVJQ0P1wyw6GR9zit9GQNDcWQiZAlvi0gI9FK5gv9WWHENQ5LaR5mYtKlL0iLBPJOos9MrQmBWwQLzekdgJXlh7W8U3dHarmmlZJmQxBHWADlE3iyPh4gySnrlYkMPeXSL6lTxKC9iTSMT4TKra1Hlcdh9sQ8qYQxnlsrKpYJt0U6bDG0OFOpM5NrRYd1e6Yy5pxXVC5hzkoijedQ6YKHahdyp");
CALL CreateReview('gabe','doctor5',2.5, 'Hes a good guy');

Call ViewReviews('doctor1','1000-01-01 00:00:00','9999-12-31 23:59:59');
Call ViewReviews('doctor3','1000-01-01 00:00:00','9999-12-31 23:59:59');
Call ViewReviews('doctor5','1000-01-01 00:00:00','9999-12-31 23:59:59');
CALL CreateDoctor('doctor5', 'ON', 'Vaughan', 'M1P5C5', '321 Lester', 'Andrew', 'Chung', NOW(), 'male', 'pediatrician,nutritionist,surgeon,botanist,neuro,pychiatrist');
Call ViewReviews('doctor5','1000-01-01 00:00:00','9999-12-31 23:59:59');

Call ViewReviews('doctor1','1000-01-01 00:00:00','1100-12-31 23:59:59');
Call ViewReviews('doctor6','1000-01-01 00:00:00','9999-12-31 23:59:59');

