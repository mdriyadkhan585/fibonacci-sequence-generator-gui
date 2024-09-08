import sys
from PySide6.QtCore import QObject, Slot, Property, Signal, QAbstractListModel, Qt
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine


class FibonacciModel(QAbstractListModel):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._data = []

    def data(self, index, role):
        if role == Qt.DisplayRole:
            return self._data[index.row()]

    def rowCount(self, index):
        return len(self._data)

    def setData(self, data):
        self.beginResetModel()
        self._data = data
        self.endResetModel()


class AppBackend(QObject):
    fibonacciOutputChanged = Signal()

    def __init__(self, model):
        super().__init__()
        self.fibonacciModel = model
        self._fibonacciOutput = ""

    @Slot(int)
    def generateFibonacci(self, n):
        if n <= 0:
            self.fibonacciModel.setData(["Please enter a positive integer."])
            self._fibonacciOutput = "Please enter a positive integer."
        else:
            sequence = self.calculate_fibonacci(n)
            self.fibonacciModel.setData(sequence)
            self._fibonacciOutput = ", ".join(map(str, sequence))
        self.fibonacciOutputChanged.emit()

    def calculate_fibonacci(self, n):
        if n == 1:
            return [0]
        elif n == 2:
            return [0, 1]

        sequence = [0, 1]
        for i in range(2, n):
            sequence.append(sequence[-1] + sequence[-2])
        return sequence

    @Property(str, notify=fibonacciOutputChanged)
    def fibonacciOutput(self):
        return self._fibonacciOutput


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)

    fibonacciModel = FibonacciModel()
    backend = AppBackend(fibonacciModel)

    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("app", backend)
    engine.rootContext().setContextProperty("fibonacciModel", fibonacciModel)
    engine.load("main.qml")

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
