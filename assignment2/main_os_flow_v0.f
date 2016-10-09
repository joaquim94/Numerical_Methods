c*****************************************************************
c
c  MAIN_OS_FLOW.f
c
c       We integrate the harmonic oscillator field with Taylor
c       from t=ti up to t=tmax
c       idir= +1 (integration forward in time); =-1 (backward)
c       np= number of intermediate points (apart from the initial one)
c           that we want to write on the file orbit.d. If np=1
c           only the initial and final points are written
c   
c  input: xi,ti,tmax,idir,np
c*****************************************************************
        implicit real*8 (a-h,o-z)
        parameter (n=2)
        dimension xi(n),x(n)
        open(10,file='orbit.d',status='unknown')
        write(*,*) 'Initial condition x(1),x(2)'
        read(*,*) (xi(i),i=1,n)
        write(*,*) 'ti,tmax,np (number of points)'
        read(*,*)ti,tmax,np
        if (tmax.ge.ti)then
c         'idir (=1 forward in time, =-1 backward)'
            idir=1
        else
            idir=-1
        endif
        do i=1,n
         x(i)=xi(i)
        enddo
         write(*,*)ti,'   initial t, initial cond:'
         write(*,*)(x(i),i=1,n)
c REMARK: xinctime positive
       xinctime=dabs(tmax-ti)/np
         write (10,*)ti,(x(ii),ii=1,n)
       do 20 i=1,np
         call flow(ti,n,x,idir,xinctime)
         write (10,*)ti,(x(ii),ii=1,n)
 20    continue
       write(*,*)ti,'  final t,  final point:'
       write(*,*)(x(i),i=1,n)
        end


       subroutine flow(t,n,x,idir,xinctemps)
       IMPLICIT REAL*8 (A-H,O-Z)
       dimension x(n)
       tmax=t+idir*xinctemps
c
c parameters for the integration
c 
        hab=0.1e-16
        hre=0.1e-16
        pabs=dlog10(hab)
        prel=dlog10(hre)
c Option of control of step
        istep=1
        ht=0.d0
 1        CALL taylor_f77_eq_os_(t,x,idir,istep,pabs,prel,
     &  tmax,ht,iordre,ifl)
c        write(10,100) t,(x(i),i=1,n)
        if (idir.eq.1.and.t.lt.tmax)go to 1
        if (idir.eq.-1.and.t.gt.tmax)go to 1
c check t=tmax
        if (dabs(t-tmax).le.1.d-13)return
        write(*,*)'problems in taylor'
        stop
c 100     format(f15.8,2f22.15)
        return
        end
