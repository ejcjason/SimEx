""" Module that holds the XFELPhotonPropagator class.

    @author : CFG
    @institution : XFEL
    @creation 20151104

"""
import numpy
import h5py

from XXX.Calculators.AbstractPhotonPropagator import AbstractPhotonPropagator


class XFELPhotonPropagator(AbstractPhotonPropagator):
    """
    Class representing a x-ray free electron laser photon propagator.
    """

    def __init__(self,  parameters=None, input_path=None, output_path=None):
        """
        Constructor for the xfel photon propagator.

        @param  :
        @type :
        @default :
        """

        # Initialize base class.
        super(XFELPhotonPropagator, self).__init__(parameters,input_path,output_path)


    def backengine(self):
        pass

    @property
    def data(self):
        """ Query for the field data. """
        return self.__data

    def _readH5(self):
        """ """
        """ Private method for reading the hdf5 input and extracting the parameters and data relevant to initialize the object. """

        # Read the file.
        file_handle = h5py.File(self.input_path, 'r')

        # Setup empty dictionary.
        parameters = {}

        # Get photon energy.
        #parameters['photon_energy'] = file_handle['params/photonEnergy'].value

        # Read the electric field data and convert to numpy array.
        data = numpy.array([file_handle['data/arrEhor'],
                            file_handle['data/arrEver']
                           ]
                          )

        # Store on object.
        self.__e_field = data

        super(XFELPhotonPropagator, self).__init__(parameters,self.input_path,self.output_path)

        file_handle.close()

    def saveH5(self):
        """ """
        """
        Private method to save the object to a file.

        @param output_path : The file where to save the object's data.
        @type : string
        @default : None
        """

        # Open the file for writing.
        file_handle = h5py.File(self.output_path, 'w')

        # Create data and parameters.
        #params = file_handle.create_group('params')
        #data = file_handle.create_group('data')
#
        #pE = params.create_dataset(name="photonEnergy",
                                   #shape=(),
                                   #dtype=numpy.float,
                                   #data=self.parameters['photon_energy'] )
#
        #Ehor = data.create_dataset(name='arrEhor', shape=self.data[0].shape, data=self.data[0])
        #Ever = data.create_dataset(name='arrEver', shape=self.data[1].shape, data=self.data[1])
#
        file_handle.close()

