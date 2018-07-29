# Convolutional Neural Networks
# cat or dog?

# Part 1

# Importing Keras Packages
from keras.models import Sequential #initialize
from keras.layers import Convolution2D #convolution, add layers
from keras.layers import MaxPooling2D #add pooling layers
from keras.layers import Flatten #pool feature maps into feature vector (input of fully connected layers)
from keras.layers import Dense #add fully connected layers

# Initializing the CNN
classifier = Sequential()


#***********************************
# ***Step 1 - Convolution***
""" 
-number feature detectors = number feature maps
-colored image = 3D array [ input_shape = 3 (colored),
 values in channel refelct RGB]
    -Tensorflow starts with dimensions of 2D arrays, then # channels
    -Theano would be like example
-b/w image = 2D array
"""
classifier.add(Convolution2D(32, 3, 3, input_shape = (64, 64, 3), activation = 'relu')) # 32 feature detectors size 3x3

#***********************************
# ***Step 2 - Pooling***
""" reduces # nodes in sequential steps, reduce feat. maps"""
classifier.add(MaxPooling2D(pool_size = (2, 2)))

# Adding 2nd layer
classifier.add(Convolution2D(32, 3, 3, activation = 'relu')) #don't need another input shape [input is feature detectors]
classifier.add(MaxPooling2D(pool_size = (2, 2)))


#***********************************
# ***Step 3 - Flattening***
"""
cannot go from input--> flattening because you'll
only have info about the one independent pixel
w/o knowing how it related to surrounding pixels,
after convolution and pooling, flattened node
is info about a feature and not pixel
"""
classifier.add(Flatten())


#**********************************
# ***Step 4 - Fully Connected Layer***
#common practice to pick a power of 2
classifier.add(Dense(output_dim = 128,  activation = 'relu'))
classifier.add(Dense(output_dim = 1,  activation = 'sigmoid'))
                     

#***********************************
# Compiling the CNN
classifier.compile(optimizer = 'adam', loss = 'binary_crossentropy', metrics = ['accuracy'])

"""****************************************"""
# Part 2 - Fitting the CNN to the images

from keras.preprocessing.image import ImageDataGenerator

train_datagen = ImageDataGenerator(
        rescale=1./255,
        shear_range=0.2,
        zoom_range=0.2,
        horizontal_flip=True)

test_datagen = ImageDataGenerator(rescale=1./255)

training_set = train_datagen.flow_from_directory('dataset/training_set',
                                                 target_size=(64, 64),
                                                 batch_size=32,
                                                 class_mode='binary')

test_set = test_datagen.flow_from_directory('dataset/test_set',
                                            target_size=(64, 64),
                                            batch_size=32,
                                            class_mode='binary')

classifier.fit_generator(training_set,
                    samples_per_epoch=8000,
                    nb_epoch=25,
                    validation_data=test_set,
                    nb_val_samples=2000)

"""make the model more accurate by creating
a "deeper" deep learning model"""









