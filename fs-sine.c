//fs-sine.c 
/* Create spike trains with Poisson distribution, mean rate is
 * sinusoidally modulated, or rectangle function. */

/* Compile with gcc -O fs-sine.c -o fs-sine -lm */ 
/*                   filename numtrains modfreq maxtime dt peakfreq seed peakdur*/
/* run with ./fs-sine tt_file  254      10.0    10.0   1e-5  1.0    1 -1
or ./fs-sine rect100- 254 2.5 10.0 1e-5 1.0 1 0.1 */
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>

/* maximum number of files to fill at one time */
#define MAXFILES 500
/* 2^31-1*/
#define PI 3.14159

double **eventtime;/* array of spike times for each synapse */
int *events; /* number of spike times in evenlist */

/**************************************************************/
void itoa(number, string)
     int number;
     char string[];
{
  int i,j;
  char s[120];

  i=0;
  do
    {
      s[i++] = number % 10 + '0';
    } while ((number /= 10) > 0);

  for (j=0; j<i; j++)
    string[i-1-j]=s[j];
  string[i] = '\0';

}
/**************************************************************/
/* allocate space ********/
  int allocate_space(numfiles, numevents)
     int numfiles;
     int numevents;
{
  int i;

  if ((events = (int *) calloc (numfiles, sizeof(int*))) == NULL)
    { 
      printf("cannot calloc %d bytes to events. \n", numfiles);
      return 0;
    }
  else
    printf("events allocated\n");

  if ((eventtime = (double **) calloc (numfiles, sizeof(double**))) == NULL)
    {
      printf("cannot malloc %d bytes to eventlist. \n", numfiles);
      return 0;
    }

  for (i=0; i<numfiles; i++)
    eventtime[i] = (double *) calloc (numevents, sizeof (double));
  printf("eventlist allocated, %d files by %d events\n", numfiles, numevents);


  return 1;
}

/****************************************************************************/

main(argc, argv)
int argc;
char **argv;
{
  /* input parameters */
  char fname[MAXFILES][120], fileroot[120];
  char extension[10];
  int numfiles; /* number of different synaptic inputs*/
  double modfreq; /* frequency of upstates */
  double maxtime; /* total time over which to generate spike trains */
  double dt;  /* timestep*/
  double peakfreq; /* peak interevent interval during upstates*/
  int seed; /* integer to initialize random number generator */
  double peakdur; /* duration of peak (for rectangular upstates)*/
  double cycle; /* inverse of frequency */
  int nparams = 8;


  /* other variables */
  int j, i;
  double time;
  int numevents;
  int totalevents;
  double rate, temp;
  double peakfraction, dtrate;
  FILE *fp;

  /***** read in parameters from command line *****/
  if (argc < nparams || argc > nparams+1) 
    {
      printf ("%d parameters (+1 more for rectagular) required, %d found: fname numtrains modfreq maxtime dt peakfreq seed\n", nparams, argc);
      return (0);
    }
  else
    {
      strcpy(fileroot, argv[1]);
      numfiles = atoi(argv[2]);
      modfreq = atof(argv[3]);
      maxtime = atof(argv[4]);
      dt = atof(argv[5]);
      peakfreq = atof(argv[6]);
      seed = atoi(argv[7]);
      if (argc==nparams+1)
	peakdur = atof(argv[8]);
      else peakdur=-1;
      printf("%s files: %d modfreq: %g maxtime: %g dt: %g peakfreq: %g Seed: %d Up duration: %g\n", 
	     fileroot, numfiles, modfreq, maxtime, dt, peakfreq, seed, peakdur);
    }

  for (i=0; i<numfiles; i++)
    {
    strcpy (fname[i], fileroot);
    itoa(i, extension);
    strcat (fname[i], extension);
    }

 /*initialize random number generator */
  srandom(seed);

  /* determine maximum number of events (which is same as number of
     event times) and allocate space for spike time array */

  numevents= (int) maxtime*peakfreq*4;

  printf("numevents=%d\n", numevents);
  if (!allocate_space(numfiles, numevents)) 
    return 0;

  totalevents=0;
  cycle=1/modfreq;
  peakfraction=peakdur/cycle;
  dtrate=peakfreq*dt;

  for (time=0; time<maxtime; time+=dt)
    {
	/* to create sinusoidal upstates: */
      if (peakdur==-1)
	rate=peakfreq*sin(2*PI*modfreq*time)*dt;
      else
      /* to create rectangular upstates: */
	{
	  temp=time/cycle;
	  rate= ((temp-(int) temp<peakfraction) ? dtrate : 0);
	}

      for (i=0; i<numfiles; i++)
	if ( ((double) random() / RAND_MAX) <= rate)
	  {
	    eventtime[i][events[i]]=time;
	    events[i]++;
	    totalevents++;
	    if (events[i] > numevents)
	      { 
		printf("too many events, file:%d, events[i]:%g\n",i, events[i]);
		return 0;
	      }
	  }
    }

  printf("total number of events=%d, frequency=%g\n", totalevents, totalevents/maxtime);

	 /* write the eventlist to individual spike time files */
  for (i=0; i<numfiles; i++)
    {
      //      printf("events for file %d, numevents=%d\n",i, events[i]);
      if ((fp = fopen(fname[i], "w")) == NULL)
	{
	  printf("Can't open output file #%d: %s.\n", i, fname[i]);
	  return 0;
	}
      else
	{
	  for (j=0; j<events[i]; j++)
	    fprintf (fp, "%g\n", eventtime[i][j]);
	  fclose(fp);
	}
    }

} /* end */

