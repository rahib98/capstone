import netherlandsRecruiter from './jeremy-akeze-doghouse-it-recruitment.jpg';
import * as S from './style';

const Recruiter = () => (
  <S.Container>
    <S.Thumbnail>
      <img
        alt="Rahib Shaikh - TechField "
        src={netherlandsRecruiter}
      />
    </S.Thumbnail>
    <S.Description>
      <h4>
        Work in the United States
        <S.Flag />
      </h4>
      <p>
        Hi! I'm Rahib Shaikh from TechField and I'm a 
        skilled Devops Engineers.,{' '}
        <a href="https://www.linkedin.com/in/jeremy-akeze-9542b396/">
          <b>follow me on Linkedin.</b>
        </a>
      </p>
    </S.Description>
  </S.Container>
);

export default Recruiter;
