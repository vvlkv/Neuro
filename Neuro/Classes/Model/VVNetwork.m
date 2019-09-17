#import "VVNetwork.h"
#import "Matrix.h"

@interface VVNetwork() {
    Matrix *idealMatrix;
    Matrix *weightMatrix;
    Matrix *reverseMatrix;
}

@end

@implementation VVNetwork


#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        idealMatrix = [[Matrix alloc] init];
        weightMatrix = [[Matrix alloc] init];
    }
    return self;
}


#pragma mark - User methods

- (void)addFigure:(NSArray *)array {
    [idealMatrix insertRow:[NSMutableArray arrayWithArray:array]];
    weightMatrix = [idealMatrix divideScalar:@2];
}

- (void)removeRowAtIndex:(NSUInteger)number {
    idealMatrix = [idealMatrix removeRowAtIndex:number];
    weightMatrix = [idealMatrix divideScalar:@2];
}
- (NSInteger)startRecognition:(NSArray *)array {
    
    NSUInteger figuresNum = [idealMatrix rowsNum];
    double T = (float)[idealMatrix columnsNum]/2;
    float stabilization = 0.1;
    float normalization = 1;
    float synapse = (float)1/figuresNum;
    NSInteger retNum = -1;
    
    reverseMatrix = [[Matrix alloc] initWithValue:[NSNumber numberWithDouble:1/figuresNum] andRows:figuresNum byColumns:figuresNum];
    [reverseMatrix clearMainDiagonal];
    Matrix *stateMatrix = [weightMatrix multipleOfVectors:array];
//    stateMatrix = [stateMatrix addScalar:[NSNumber numberWithDouble:T]];
    Matrix *exitNeuron = [stateMatrix desicionUsing:(double)T];
    while (normalization > stabilization) {
        Matrix *oldState = [[Matrix alloc] initWithArray:exitNeuron.matrix
                                                 andRows:[exitNeuron rowsNum]
                                               byColumns:[exitNeuron columnsNum]];
        stateMatrix = [exitNeuron newNeuronWithSynapse:synapse];
        exitNeuron = [stateMatrix desicionUsing:(double)T];
        normalization = [[exitNeuron subtractMatrix:oldState] length];
    }
    BOOL isFounded = NO;
    for (NSNumber *number in stateMatrix.matrix[0]) {
        if ([number doubleValue] > 0) {
            retNum = (isFounded) ? -1 : (NSInteger)[stateMatrix.matrix[0] indexOfObject:number];
        }
    }
    return retNum;
}

@end
